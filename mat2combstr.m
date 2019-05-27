function combstr = mat2combstr(mat)
    if (isempty(mat))
        combstr = "xxx";
        return;
    end
        
    str = string(mat);
    combstr = "";
    str_len = length(str);
    for i = 1:str_len - 1
        str(i) = str(i) + ",";
        combstr = combstr + str(i);
    end
    combstr = combstr + str(str_len);
end