function [x, y] = coordinate2xy(strxy)
% 输入的strxy是坐标的字符串形式
% 输出是 坐标的x轴和y轴的字符串形式
x = ''; y = ''; i = 1;% 初始化
if strxy(i) == '('
   i = i + 1;
   while strxy(i) ~= ','
       x = strcat(x,strxy(i));
       i = i + 1;
   end
end
if strxy(i) == ','
    i = i + 1;
    while strxy(i) ~= ')'
        y = strcat(y,strxy(i));
        i = i + 1;
    end
end