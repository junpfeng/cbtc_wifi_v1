function mycell = combstr2Line(str)
    if (str == "xxx")
        mycell = {};
        return;
    end
    
    mat = combstr2mat(str);
    mat_len = length(mat);
    div_len = mat_len/5; % ÿ5������һ��ѭ��

    mycell = cell(1,div_len*3);  % ��ʼ��
    cell_index = 1;
    
    for i = 1:div_len
        j = 1;
        while(j <= 5 ) % forѭ����ѭ��������ѭ�������޷����ı䣬���Ҫʹ��while�滻
            if j == 1
                mycell{cell_index} = mat((i-1)*5 + j);
                cell_index = cell_index + 1;
                j = j + 1;
                continue;
            else
                tmp = [mat((i - 1)*5 + j), mat((i - 1)*5 + j + 1)];
                j = j + 2;
                mycell{cell_index} = tmp;
                cell_index = cell_index + 1;
            end
        end
    end

end