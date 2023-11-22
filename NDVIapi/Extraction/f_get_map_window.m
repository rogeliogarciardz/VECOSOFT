function [lon_map,lat_map] = f_get_map_window(dir_data,kml,umbral)

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\'+kml+'.kml');
    min_lon = min(bndry_lon);
    max_lon = max(bndry_lon);
    
    min_lat = min(bndry_lat);
    max_lat = max(bndry_lat);

    ajuste =  umbral * (max_lon - min_lon);
    lon_map = [min_lon-ajuste max_lon+ajuste];
    ajuste =  umbral * (max_lat - min_lat);
    lat_map = [min_lat-ajuste max_lat+ajuste];
    
end