disp("Hola VECOSOFT");
import matlab.io.hdfeos.*
% info_hdf = f_infohdfs2table(dir_data,"MOD13Q1");


i_v06 = [3950 3950];
t_v06 = [850 462];

i_v07 = [0 3950];
t_v07 = [30 462];

i_v08=[0 0];
% t_v08=[1000 2400];
t_v08=[4800 4800];

ruta="D:\DATA\MOD13Q1\061\";
file1=ruta+'MOD13Q1.A2022001.h08v06.061.2022018201520.hdf';
file2=ruta+'MOD13Q1.A2022001.h08v07.061.2022018162937.hdf';


% -------------------------------------------------------------- funcional
 i_v06_d = [3950 3950];
 t_v06_d = [462 850];
 % --------------------------------------------------------------


%    ____________________________________________________________bien norte
    gfid = gd.open(file1 );
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,"MODIS_Grid_16DAY_250m_500m_VI" );
    %obtenemos el ndvi solo el ndvi
    [ndvi,~,~] = gd.readField(gridID,"250m 16 days NDVI",i_v06_d,t_v06_d);
    % cerramos los punteros al archivoclear
    gd.detach(gridID);
    gd.close(gfid);

    ndvi=ndvi';
    ndvi=flipud(ndvi);


    gfid = gd.open(file1 );
%     indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,"MODIS_Grid_16DAY_250m_500m_VI" );
%     obtenemos el ndvi, latitud y longitud
    [ndvi_x1,lat,lon] = gd.readField(gridID,"250m 16 days NDVI",i_v06,t_v06);
%     cerramos los punteros al archivoclear
    gd.detach(gridID);
    gd.close(gfid);
%    ____________________________________________________________bien norte



i_v07_d = [3950 0];
t_v07_d = [462 30];

%



    gfid = gd.open(file2 );
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,"MODIS_Grid_16DAY_250m_500m_VI" );
    %obtenemos el ndvi, latitud y longitud
    [ndvi2,~,~] = gd.readField(gridID,"250m 16 days NDVI",i_v07_d,t_v07_d);
    % cerramos los punteros al archivoclear
    gd.detach(gridID);
    gd.close(gfid);

    gfid = gd.open(file2 );
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,"MODIS_Grid_16DAY_250m_500m_VI" );
    %obtenemos el ndvi, latitud y longitud
    [ndvi_x2,lat2,lon2] = gd.readField(gridID,"250m 16 days NDVI",i_v07,t_v07);
    % cerramos los punteros al archivoclear
    gd.detach(gridID);
    gd.close(gfid);

      ndvi2=ndvi2';
      ndvi2=flipud(ndvi2);
%       pcolor(ndvi2);shading interp

%     ndvi_x=[ndvi; ndvi2];
%     lat_x=[lat;lat2];
%     lon_x=[lon;lon2];

%     pcolor(ndvi_data2); shading interp___________________________________

     set_model_map();
     set_hdf(lon,lat,ndvi);

     figure
     set_model_map();
     set_hdf(lon2,lat2,ndvi2);

     ndvi_x=[ndvi; ndvi2];
     lon_x=[lon; lon2];
     lat_x=[lat; lat2];

     figure
     set_model_map();
     set_hdf(lon_x,lat_x,ndvi_x);



     ndvi_xx=[ndvi_x1; ndvi_x2];
     figure
     set_model_map();
     set_hdf(lon_x,lat_x,ndvi_xx);

%





%  pcolor(ndvi2);shading interp
%  figure
%  pcolor(ndvi);shading interp
%


