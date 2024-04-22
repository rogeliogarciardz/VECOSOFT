function [tbltmp,tblprec] = f_get_clicom_mly(dir_data,idstn,years)
%F_GET_CLICOM_MLY Obtener infromacion de precipitacion y temperatura mensuales de
%clicom
%   Detailed explanation goes here

    opts = detectImportOptions(dir_data+"CLICOM\idestaciones.csv");
    opts = setvaropts(opts,'INICIO','InputFormat','dd/MM/uuuu');
    opts = setvaropts(opts,'FIN','InputFormat','dd/MM/uuuu');
    cvsmetstn = readtable(dir_data+"CLICOM\idestaciones.csv",opts);
    
    edo = floor(idstn/1000);
    infstn = cvsmetstn(cvsmetstn.CLAVE==idstn,:);

    if ( ~isempty(infstn))
        disp("===  INFORMACIÓN:"+idstn+" ======");
        disp("LAT: "+infstn.LATG+"°"+infstn.LATM+"'"+infstn.LATS+"''");
        disp("LON: "+infstn.LONG+"°"+infstn.LONM+"'"+infstn.LONS+"''");
        disp("ALTURA: "+infstn.ALTURA+" m");
        
        %elem = 203; % 203 TEMP MEDIA MES °C
        %elem = 208; % 208 LLUVIA TOTAL MES mm
        elem = [203 208];
        colanio = 4;
        colelem = 3;
        colmeses= 5:2:27; %[5 7 9 11 13 15 17 19 21 23 25 27];
        
        mlyfile = dir(dir_data+"CLICOM\MLY\"+edo+"*.CSV");
        if(~isempty(mlyfile))
            disp("ARCHIVO: "+mlyfile.name);
        
            mlyinfoall = readmatrix(mlyfile.folder+"\"+mlyfile.name);
            mlyinfostn = mlyinfoall(( mlyinfoall(:,2) == idstn &  ismember(mlyinfoall(:,3), elem)),:);
            mlyinfostn = mlyinfostn(:,[colanio colelem colmeses]);
            mlyinfostn(mlyinfostn==-99999)=nan;
            mlyinfostn = mlyinfostn((ismember (mlyinfostn(:,1),years)),:);
            disp("==============================");
        
            tblprec = mlyinfostn( (mlyinfostn(:,2) == 208),[1 3:14]);
            tbltmp = mlyinfostn( (mlyinfostn(:,2) == 203),[1 3:14]);
            tblprec = f_fix_miss_years(tblprec,years);
            tbltmp = f_fix_miss_years(tbltmp,years);
    
        
        end
    else
        disp("ERROR: Station not found :(");
    end

end

%% fix miss years

function tbl = f_fix_miss_years(tblinfo,years)
    tbl =  NaN(length(years),13);
    for i=1:length(years)
        tbl (i,1) = years(i);
        idtmp = tblinfo(:,1)==years(i);
        if(sum(idtmp)==1)
            tbl (i,2:end) = tblinfo(idtmp,2:end);
        end
    end
end