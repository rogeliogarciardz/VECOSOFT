disp("Hola VECOSOFT");
import matlab.io.hdfeos.*
nuevos=f_rm_pixel_baja_calidad(arr_ndvi,arr_ndvi_re);

serie_nv = reshape(nuevos(320,400,:),[],1);
% confiabilidad de los datos releabilyti
serie_re = reshape(arr_ndvi_re(320,400,:),[],1);

figure;

yyaxis left 
plot(serie_nv);
title(length(serie_nv))
% xlabel('Tiempo')
% ylabel('NDVI')
% yyaxis right
% plot(serie_re);
% ylabel('Re')
% 
% malos=serie_re(serie_re>=3);
% disp("Pixeles Anomalos: "+length(malos));

new_data=f_fillmissing_linear(nuevos,1);

