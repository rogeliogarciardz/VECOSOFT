
[~,tam]=size(anios_maps.Matriz);

for i=1:tam
    figure;
    f_draw_map(lon_mapa,lat_mapa,lon,lat,anios_maps.Matriz{1,i },archivo_kml+anio,[0 1],"NDVI","NDVI");
    f_draw_kml(dir_data,archivo_kml,1,'k');
    ax = gca;
    ax.FontSize=18; 
end
