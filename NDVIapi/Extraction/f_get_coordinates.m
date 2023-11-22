function [coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam,ndvi_tam] = f_get_coordinates(dir_data,kml,producto,info_hdf,umbral)
import matlab.io.hdfeos.*
disp(">>>>> Obteniendo la zona de estudio");

product = ["MOD13A1";"MOD13A2";"MOD13Q1"];
grid = ["MOD13A1";"MODIS_Grid_16DAY_1km_VI";"MODIS_Grid_16DAY_250m_500m_VI"];
ndvi = ["MOD13A1";"1 km 16 days NDVI";"250m 16 days NDVI"];
evi = ["MOD13A1";"1 km 16 days EVI";"250m 16 days EVI"];
quality = ["MOD13A1";"1 km 16 days VI Quality";"250m 16 days VI Quality"];
reliability = ["MOD13A1";"1 km 16 days pixel reliability";"250m 16 days pixel reliability"];
mod13 = table(product,grid,ndvi,evi,quality,reliability);

dir_archivos = dir_data+""+producto+"\061\*.hdf";
disp(dir_archivos);

lista_archivos = dir(dir_archivos);
num_archivos = length(lista_archivos);

if(num_archivos > 0)

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\'+kml+'.kml');
    min_lon = min(bndry_lon);
    max_lon = max(bndry_lon);
    
    min_lat = min(bndry_lat);
    max_lat = max(bndry_lat);

    [row,~,~] = find(bndry_lon==min_lon);
    lat_min_lon = bndry_lat(row);
    
    [row,~,~] = find(bndry_lon==max_lon);
    lat_max_lon = bndry_lat(row);

    %% Recuperar la información
    disp(">>>>> Analizando "+num_archivos+" archivos");
    
    producto = info_hdf(1,"Producto").Producto;
    actual = mod13(strcmp(mod13.product,producto),:);
    % Abrir primer h08v06 archivo hdf para obtener las matrices de latitud y
    % longitud. Despues abrir el segundo archvio h08v07 y unir al primero
    % para tener la información completa

    gfid = gd.open( info_hdf(1,"v6").v6  );
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid, actual(1,"grid").grid );
    %obtenemos el ndvi, latitud y longitud
    [ndvi1,lat1,lon1] = gd.readField(gridID,actual(1,"ndvi").ndvi); 
    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    gfid = gd.open( info_hdf(1,"v7").v7);
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,actual(1,"grid").grid );
    %obtenemos el ndvi, latitud y longitud
    [ndvi2,lat2,lon2] = gd.readField(gridID,actual(1,"ndvi").ndvi);
    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    [tam_cuad,~] = size(lat1);
 %% 
plat = zeros(2,1);
if(max_lat > 20)
    plat(1)=1;
    [~,col,~] = find(lat1(1,:)<max_lat);
    id_max_lat = col(1); 
else
    plat(1)=0;
    %buscar el id en lat2
    [~,col,~] = find(lat2(1,:)<max_lat);
    id_max_lat = col(1); 
end

if(min_lat > 20)
    plat(2)=1;
    [~,col,~] = find(lat1(1,:)<=min_lat);
    id_min_lat = col(1);
else
    plat(2)=0;
    [~,col,~] = find(lat2(1,:)<=min_lat);
    id_min_lat = col(1);
end


if(lat_min_lon>20)
    [~,col,~] = find(lat1(1,:)<=lat_min_lon);
   
     [row,~,~] = find(lon1(:,col(1))>=min_lon);
    id_min_lon = row(1);
else
    [~,col,~] = find(lat2(1,:)<=lat_min_lon);
   
     [row,~,~] = find(lon2(:,col(1))>=min_lon);
    id_min_lon = row(1);
end

if(lat_max_lon>20)
    [~,col,~] = find(lat1(1,:)<=lat_max_lon);
   
     [row,~,~] = find(lon1(:,col(1))>=max_lon);
    id_max_lon = row(1);
else
    [~,col,~] = find(lat2(1,:)<=lat_max_lon);
   
     [row,~,~] = find(lon2(:,col(1))>=max_lon);
    id_max_lon = row(1);
end
%% Ajustes
id_max_lat=id_max_lat-4;
id_min_lat=id_min_lat+4;

ajuste = floor( umbral * (id_max_lon-id_min_lon));

if( (id_max_lon+ajuste) > 0 && (id_max_lon+ajuste) <  tam_cuad )
    id_max_lon=id_max_lon+ajuste;
end

if( (id_min_lon-ajuste) > 0 && (id_min_lon-ajuste) <  tam_cuad )
    id_min_lon=id_min_lon-ajuste;
end


%% longitud
a=sum(plat);
switch a
    case 0
        %cuadrante de inicio y tamaño del area de estudio
        coord_1k_v6_inicio = [0 0];
        coord_1k_v6_tam = [0 0];
        
        %h08v06
        coord_1k_v7_inicio = [id_min_lon id_max_lat];
        coord_1k_v7_tam = [id_max_lon-id_min_lon id_min_lat-id_max_lat];
        
        ndvi_tam = [id_max_lon-id_min_lon id_min_lat-id_max_lat];
    case 1
        %cuadrante de inicio y tamaño del area de estudio
        coord_1k_v6_inicio = [id_min_lon id_max_lat];
        coord_1k_v6_tam = [id_max_lon-id_min_lon tam_cuad-id_max_lat];
        
        %h08v06
        coord_1k_v7_inicio = [id_min_lon 0 ];
        coord_1k_v7_tam = [id_max_lon-id_min_lon id_min_lat];
        
        ndvi_tam = [id_max_lon-id_min_lon tam_cuad-id_max_lat+id_min_lat];

    case 2
        %h08v06
        coord_1k_v6_inicio = [id_min_lon id_max_lat];
        coord_1k_v6_tam = [id_max_lon-id_min_lon id_min_lat-id_max_lat];

        %cuadrante de inicio y tamaño del area de estudio
        coord_1k_v7_inicio = [0 0];
        coord_1k_v7_tam = [0 0];

        ndvi_tam = [id_max_lon-id_min_lon id_min_lat-id_max_lat];
    otherwise
        disp('ups!');    
end

end

end