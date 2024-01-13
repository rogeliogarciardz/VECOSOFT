function [area_naranja] = f_make_area(arr_ndvi,result_net,study_area)
    [alto,ancho,~]=size(arr_ndvi);
    
    ind_temp=1;
    mask_tep=zeros(alto,ancho);
    
    for i=1:alto
         for j=1:ancho
            if(study_area(i,j)==1)
                mask_tep(i,j) = result_net(ind_temp);
                ind_temp=ind_temp+1;
            end
        end
    end
    
    area_naranja=mask_tep;
end

