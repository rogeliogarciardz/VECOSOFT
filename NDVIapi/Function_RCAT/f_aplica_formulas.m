function [tab_data] = f_aplica_formulas(datos,study_area,valor)
    [alto,ancho,~]=size(datos);
    temp_Mediana=[];
    temp_Mean=[];
    temp_Mode=[];
    temp_Range=[];
    temp_Desv=[];
    temp_Min=[];
    temp_Max=[];
    temp_Mad=[];
    temp_valor=[];
    id=1;

    for i=1:alto
         for j=1:ancho
            if(study_area(i,j)==1)
                serie = reshape(datos(i,j,:),[],1);
                temp_Mediana(id) =median(serie);
                temp_Mean(id)=mean(serie);
                temp_Mode(id)=mode(serie);
                temp_Range(id)=range(serie);
                temp_Desv(id)=std(serie);
                temp_Min(id)=min(serie);
                temp_Max(id)=max(serie);
                temp_Mad(id)=mad(serie);
                temp_valor(id)=valor;
                id=id+1;
            end
        end
    end
    tab_data=table( temp_Mediana',temp_Mean',temp_Mode',temp_Range',temp_Desv',temp_Min',temp_Max',temp_Mad',temp_valor',VariableNames=["Mediana","Promedio","Moda","Rango","Desviacion","Minimos","Maximos","Mad","Valor"]);
end

