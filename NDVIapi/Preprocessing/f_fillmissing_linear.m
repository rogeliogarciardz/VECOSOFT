function [filled,num_h] = f_fillmissing_linear(data,size_fill)

    num_h = sum(isnan(data));

    if (size_fill==0)
        filled = fillmissing(data,"linear");
    elseif (size_fill==1)
        filled = m_fillmissing_linear1(data);
    elseif(size_fill==2)
        filled1 = m_fillmissing_linear1(data);
        filled = m_fillmissing_linear2(filled1);
    else
        filled = data;
    end
end

function filled = m_fillmissing_linear1(data)
tam = length(data);
for i=1:tam
    if(isnan(data(i)))
        if(i==1 && ~isnan(data(i+1)))
            data(i) = data(i+1);
        elseif (i==1 && isnan(data(i+1)))
            continue;
        elseif(i==tam && ~isnan(data(i-1)))
            data(i) = data(i-1);
        elseif(~isnan(data(i-1))  && ~isnan(data(i+1)))
            data(i) = (data(i-1) + data(i+1))/2;
        end
    end
end
filled =data;
end

function filled = m_fillmissing_linear2 (data)
tam = length(data);
for i=1:tam
    if(isnan(data(i)))
        if(i==1 && isnan(data(i+1)) )
            data(i) = data(i+2);
            data(i+1) = data(i);
        elseif( i == tam-1 && isnan(data(tam)))
            data(i) = data(i-1);
            data(i+1) = data(i);
        elseif(~isnan(data(i-1)) && isnan(data(i+1)) && ~isnan(data(i+2)) )
                data(i) = ((data(i+2) - data(i-1))/3)+data(i-1);
                data(i+1) = ((data(i+2) - data(i-1))/3)+data(i);
        end
    end
end

filled = data;
end
