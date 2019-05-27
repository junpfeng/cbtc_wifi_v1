function mat = combstr2mat(str)
    str = textscan(str, '%f', 'delimiter', ',');
    str = str{1};
    mat = str.'; 
end