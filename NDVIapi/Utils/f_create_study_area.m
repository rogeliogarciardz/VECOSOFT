function area_estudio = f_create_study_area(kml_file,lat,lon)
    %% crear matriz solo de puntos dentro del area de estudio
    disp("Creando área de estudio!!!");
    %[~,R] = readgeoraster('boston.tif');
    [~,R] = readgeoraster('LE70260442002054EDC01_B1.TIF');
    proj = R.ProjectedCRS;
    proj.GeographicCRS.Name;

    [bndry_lon,bndry_lat,~] = read_kml(kml_file);
    [x,y] = projfwd(proj,bndry_lat,bndry_lon);

    [xlat,ylon] = projfwd(proj,lat,lon);
    area_estudio = inpolygon(xlat,ylon,x,y);
end

    