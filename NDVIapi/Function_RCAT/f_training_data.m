function [data_tab] = f_training_data(datos,study_area,valor)

    [alto,ancho,~]=size(datos);
    pixl=[];
    valor_temp=[];
    id=1;

    for i=1:alto
         for j=1:ancho
            if(study_area(i,j)==1)
                pixl(id)=datos(i,j);
                valor_temp(id)=valor;
                id=id+1;
            end
        end
    end

data_tab=table( pixl',valor_temp',VariableNames=["Pixl","Valor"]);
end

