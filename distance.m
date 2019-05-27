function d = distance(a, b, F, x)
% a，b是两个点坐标，是包含两个元素的数组
% F是曲线方程，是一个符号表达式
% x是符号表达式中的符号变量，不写的情况下，默认符号变量为x
    if nargin == 2 % 计算两点之间的直线距离
        d =eval(vpa(sqrt((a(1)-b(1))^2 + (a(2)-b(2))^2)));
    end
    if nargin == 3 
        syms x;
        Fd = diff(F);
        d = eval(vpa(int(@(x)(sqrt(Fd^2+1)),x,a(1),b(1))));
    end
    if nargin == 4
        Fd = diff(F,x);
        d = eval(vpa(int(@(x)(sqrt(Fd^2+1)),x,a(1),b(1))));
    end
end