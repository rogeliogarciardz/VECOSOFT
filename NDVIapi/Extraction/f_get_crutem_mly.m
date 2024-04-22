function [tbltmp,tblprec] = f_get_crutem_mly(dir_data,idstn,years)
%F_GET_CRUTEM_MLY Obtener datos mensuales de CRUTEM de tempreratura y
%precipitación
%   Detailed explanation goes here
    suftmp = ".tmp.txt";
    sufprec = ".pre.txt";
    
    
    [buffer,f] = f_load_file(dir_data+"CRUTEM\RH26\"+idstn+suftmp);
    if (f)
        tbltmp = f_fix_data(buffer,years);
%     else
%         tbltmp=-1;
    end
    
    [buffer,f] = f_load_file(dir_data+"CRUTEM\RH26\"+idstn+sufprec);
    if (f)
        tblprec = f_fix_data(buffer,years);
%     else
%         tblprec=-1;
    end

end

%% load data
function [buffer,f] = f_load_file(file)
    formatSpec = '%d %d %f %d';
    sizeA = [4 Inf];

    fileID = fopen(file,'r');
    if(fileID ~= -1)
        f=true;
        fgetl(fileID) ;                                  % Read/discard line.
        fgetl(fileID) ;                                  % Read/discard line.
        fgetl(fileID) ;  
        fgetl(fileID) ;  
        fgetl(fileID) ;  
        fgetl(fileID) ;  
        fgetl(fileID) ;  
        buffer = fscanf(fileID,formatSpec,sizeA) ;                    % Read rest of the file.
        fclose(fileID);
    
    else
        f=false;
        buffer=-1;
        disp("Error: File of data ["+file+"] not found :(");
    end
end
%% fix data
function tbl = f_fix_data(tblin,years)
    tblin = tblin';    
    tbl =  NaN(length(years),13);
    for i=1:length(years)
        tbl (i,1) = years(i);
        idtmp = tblin(:,1)==years(i);
        if(sum(idtmp)==12)
            tbl (i,2:end) = tblin(idtmp,3);
        end
    end
end