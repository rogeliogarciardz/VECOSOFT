function [lat,lon,data_test] = f_get_latlon(info_hdf,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam)
import matlab.io.hdfeos.*
disp(">>>>> Obteniendo latitud y longitud");

product = ["MOD13A1";"MOD13A2";"MOD13Q1"];
grid = ["MOD13A1";"MODIS_Grid_16DAY_1km_VI";"MODIS_Grid_16DAY_250m_500m_VI"];
ndvi = ["MOD13A1";"1 km 16 days NDVI";"250m 16 days NDVI"];
evi = ["MOD13A1";"1 km 16 days EVI";"250m 16 days EVI"];
quality = ["MOD13A1";"1 km 16 days VI Quality";"250m 16 days VI Quality"];
reliability = ["MOD13A1";"1 km 16 days pixel reliability";"250m 16 days pixel reliability"];
mod13 = table(product,grid,ndvi,evi,quality,reliability);

[num_registros,~] = size(info_hdf);
a=0;

if(num_registros > 0)
    %% Recuperar la información
    
    producto = info_hdf(1,"Producto").Producto;
    actual = mod13(strcmp(mod13.product,producto),:);

    if(sum(coord_1k_v6_tam) > 0)
        gfid = gd.open( info_hdf(1,"v6").v6  );
        % indicar que requerimos los datos de MODIS
        gridID = gd.attach(gfid, actual(1,"grid").grid );
        %obtenemos el ndvi, latitud y longitud
        [ndvi1,lat1,lon1] = gd.readField(gridID,actual(1,"ndvi").ndvi,coord_1k_v6_inicio,coord_1k_v6_tam); 
        % cerramos los punteros al archivo
        gd.detach(gridID);
        gd.close(gfid);
        a=a+1;
    end

    if(sum(coord_1k_v7_tam) > 0)
        gfid = gd.open( info_hdf(1,"v7").v7);
        % indicar que requerimos los datos de MODIS
        gridID = gd.attach(gfid,actual(1,"grid").grid );
        %obtenemos el ndvi, latitud y longitud
        [ndvi2,lat2,lon2] = gd.readField(gridID,actual(1,"ndvi").ndvi,coord_1k_v7_inicio,coord_1k_v7_tam);
        % cerramos los punteros al archivo
        gd.detach(gridID);
        gd.close(gfid);
        a=a+2;
    end

   switch a
        case 1
             %mezclar matrices
            lat = lat1 ;
            lon = lon1 ;
            data_test =ndvi1 ;
        case 2
            lat = lat2 ;
            lon = lon2 ;
            data_test =ndvi2 ;
        case 3
            %mezclar matrices
            lat = [lat1 lat2];
            lon = [lon1 lon2];
            data_test =[ndvi1 ndvi2];
        otherwise
            disp('ups!');
   end
end
 
end