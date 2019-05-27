function mycell = combstr2Circle(str)

    if (str == "xxx")
        mycell = {};
        return;
    end
    
    mat = combstr2mat(str);
    mat_len = length(mat);
    div_len = mat_len/8; % ÿ8������һ��ѭ��
    
    mycell = cell(1, div_len*5);
    cell_index = 1;
    for i = 1:div_len
        j = 1;
        while(j <= 8 ) % forѭ����ѭ��������ѭ�������޷����ı䣬���Ҫʹ��while�滻
            if (j == 1 || j == 8)
                mycell{cell_index} = mat((i-1)*8 + j);
                cell_index = cell_index + 1;
                j = j + 1;
                continue;
            else
                tmp = [mat((i - 1)*8 + j), mat((i - 1)*8 + j + 1)];
                j = j + 2;
                mycell{cell_index} = tmp;
                cell_index = cell_index + 1;
            end
        end
    end


end