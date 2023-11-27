function [study_area] = f_get_study_area(dir_data,kml_file,lat,lon,modis_product,ndvi_tam)

    % crear matriz de 0 y 1 que delimitan el área de estudio
    ae = exist("study_area","var");
    if ae == 0  %% no existe
        ae = exist("study_area_"+kml_file+"_"+modis_product+".mat","file");
        if ae == 2
            disp(">>> Cargando área de estudio");
            load ("study_area_"+kml_file+"_"+modis_product);
    
            if( numel(study_area) ~= ( ndvi_tam(1)*ndvi_tam(2)) )
                disp("La variable area_estudio sera sustituida 1");
                study_area = f_create_study_area(dir_data+'KML\'+kml_file+'.kml',lat,lon);
                save ("study_area_"+kml_file+"_"+modis_product+".mat",'study_area');
            else
                disp(">>> Área de estudio existente 1");
            end
    
        else
            study_area = f_create_study_area(dir_data+'KML\'+kml_file+'.kml',lat,lon);
            save ("study_area_"+kml_file+"_"+modis_product+".mat",'study_area');
        end
    else
        if( numel(study_area) ~= ( ndvi_tam(1)*ndvi_tam(2)) )
            disp("La variable area_estudio sera sustituida 2");
            study_area = f_create_study_area(dir_data+'KML\'+kml_file+'.kml',lat,lon);
            save ("study_area_"+kml_file+"_"+modis_product+".mat",'study_area');
        else
            disp(">>> Área de estudio existente 2");
        end
    end
    
end