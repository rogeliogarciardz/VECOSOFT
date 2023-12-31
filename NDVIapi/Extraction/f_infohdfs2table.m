function info_hdf = f_infohdfs2table(dir_data,product)
disp(">>>>> Obteniendo información de archivos sobre fechas ... ");

products = {'MOD13A1', 'MOD13A2', 'MOD13Q1'};

if( ismember(product,products) )
    
    %Lista de archivos HDF del completas para analizar la información 
    lista_archivos = dir(dir_data+''+product+'\061\'+product+'.A*.hdf');
    num_archivos = length(lista_archivos);
    disp(">>>>> Analizando "+num_archivos+" archivos");
    i=1;

    %declaracion de variables
    idx =zeros(1,num_archivos/2) ;
    anio =zeros(1,num_archivos/2) ;
    diaj = zeros(1,num_archivos/2) ;
    dia = zeros(1,num_archivos/2) ;
    mes = zeros(1,num_archivos/2) ;
    estacion = zeros(1,num_archivos/2) ;
    v6 = zeros(1,num_archivos/2) ;
    v7 = zeros(1,num_archivos/2) ;
    v6 = string(v6);
    v7 = string(v7);
    calidad = zeros(1,num_archivos/2) ;
    productos = zeros(1,num_archivos/2) ;
    productos = string(productos);
    
    
    if(num_archivos > 0)
        for k = 1:2:num_archivos
            idx(i) = i;
            diaj(i) = str2double( extractBetween(lista_archivos(k).name,14,16));
            anio(i) = str2double(extractBetween(lista_archivos(k).name,10,13));
            [dia(i),mes(i),estacion(i)] = f_month_dayj(diaj(i),anio(i),dir_data);
    
    
            v6(i) = lista_archivos(k).folder + "\" + lista_archivos(k).name; 
            v7(i) = lista_archivos(k).folder + "\" + lista_archivos(k+1).name; 
    
            
            calidad(i) = -1;
            productos(i) = ""+product;

            i=i+1;
    
        end
    
        info_hdf = table(idx',diaj',dia',mes',estacion',anio',v6',v7',calidad',productos','VariableNames',["idx","diaj","dia","mes","estacion","anio","v6","v7","Calidad","Producto"]);
    else
        warnig(">>>>> No hay imagenes disponibles");
    end
else
    warning('Producto ndvi no reconocido o no soportado!!');
end