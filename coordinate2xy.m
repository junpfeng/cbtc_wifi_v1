function [x, y] = coordinate2xy(strxy)
% �����strxy��������ַ�����ʽ
% ����� �����x���y����ַ�����ʽ
x = ''; y = ''; i = 1;% ��ʼ��
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