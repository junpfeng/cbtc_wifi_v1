function mycell = combstr2Circle(str)

    if (str == "xxx")
        mycell = {};
        return;
    end
    
    mat = combstr2mat(str);
    mat_len = length(mat);
    div_len = mat_len/8; % 每8个数字一个循环
    
    mycell = cell(1, div_len*5);
    cell_index = 1;
    for i = 1:div_len
        j = 1;
        while(j <= 8 ) % for循环的循环遍历在循环体内无法被改变，因此要使用while替换
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