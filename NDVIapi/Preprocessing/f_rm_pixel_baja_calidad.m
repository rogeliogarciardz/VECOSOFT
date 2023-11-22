function [data_n,nh] = f_rm_pixel_baja_calidad(data,qa)
   
        data_n=data;
        % eliminar datos de mala calidad
        data_n(qa ~= 0 & qa ~= 1)=nan;
        nh= numel(data_n(isnan(data_n)));
end