function [ndvi,evi,calidad,disponibilidad] = f_get_ndvi(info,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam)
    import matlab.io.hdfeos.*

    a=0;
    product = ["MOD13A1";"MOD13A2";"MOD13Q1"];
    grid = ["MOD13A1";"MODIS_Grid_16DAY_1km_VI";"MODIS_Grid_16DAY_250m_500m_VI"];
    ndvi = ["MOD13A1";"1 km 16 days NDVI";"250m 16 days NDVI"];
    evi = ["MOD13A1";"1 km 16 days EVI";"250m 16 days EVI"];
    quality = ["MOD13A1";"1 km 16 days VI Quality";"250m 16 days VI Quality"];
    reliability = ["MOD13A1";"1 km 16 days pixel reliability";"250m 16 days pixel reliability"];
    mod13 = table(product,grid,ndvi,evi,quality,reliability);

    producto = info.Producto;
    actual = mod13(strcmp(mod13.product,producto),:);

    if(sum(coord_1k_v6_tam) > 0)

        gfid = gd.open( info.v6);
        % indicar que requerimos los datos de MODIS
        gridID = gd.attach(gfid,actual(1,"grid").grid);
        %obtenemos el ndvi, latitud y longitud
        [ndvi1,~,~] = gd.readField(gridID,actual(1,"ndvi").ndvi,coord_1k_v6_inicio,coord_1k_v6_tam); 
        [evi1,~,~] = gd.readField(gridID,actual(1,"evi").evi,coord_1k_v6_inicio,coord_1k_v6_tam); 
        [calidad1,~,~] = gd.readField(gridID,actual(1,"quality").quality,coord_1k_v6_inicio,coord_1k_v6_tam); 
        [disponibilidad1,~,~] = gd.readField(gridID,actual(1,"reliability").reliability,coord_1k_v6_inicio,coord_1k_v6_tam); 
    
        % cerramos los punteros al archivo
        gd.detach(gridID);
        gd.close(gfid);
        a=a+1; 
        ndvi1(ndvi1<0)=0;
        evi1(evi1<0)=0;

    end
    if(sum(coord_1k_v7_tam) > 0)
        gfid = gd.open( info.v7);
        % indicar que requerimos los datos de MODIS
        gridID = gd.attach(gfid,actual(1,"grid").grid);
        %obtenemos el ndvi, latitud y longitud
        [ndvi2,~,~] = gd.readField(gridID,actual(1,"ndvi").ndvi,coord_1k_v7_inicio,coord_1k_v7_tam);
        [evi2,~,~] = gd.readField(gridID,actual(1,"evi").evi',coord_1k_v7_inicio,coord_1k_v7_tam);
        [calidad2,~,~] = gd.readField(gridID,actual(1,"quality").quality,coord_1k_v7_inicio,coord_1k_v7_tam);
        [disponibilidad2,~,~] = gd.readField(gridID,actual(1,"reliability").reliability,coord_1k_v7_inicio,coord_1k_v7_tam);
    
        % cerramos los punteros al archivo
        gd.detach(gridID);
        gd.close(gfid);
        a=a+2;  
        ndvi2(ndvi2<0)=0;
        evi2(evi2<0)=0;
    end

 switch a
        case 1
             %mezclar matrices
            ndvi = double(ndvi1 ).*0.0001;
            evi = double(evi1 ).*0.0001;
              
            calidad = double(calidad1 );
            disponibilidad = double(disponibilidad1 );
        case 2
            ndvi = double(ndvi2 ).*0.0001;
            evi = double(evi2 ).*0.0001;
              
            calidad = double(calidad2 );
            disponibilidad = double(disponibilidad2 );
        case 3
            %mezclar matrices
            ndvi = double([ndvi1 ndvi2]).*0.0001;
            evi = double([evi1 evi2]).*0.0001;
              
            calidad = double([calidad1 calidad2]);
            disponibilidad = double([disponibilidad1 disponibilidad2]);
        otherwise
            disp('ups!')
   end

  


end