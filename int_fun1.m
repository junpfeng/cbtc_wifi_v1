function f = int_fun1(x,lamda0,lamda1,tao)
%UNTITLED 积分中的第一个被积函数
%   此处显示详细说明
    f = exp(-x.^2).*erfc((lamda0/lamda1)*x+tao/(sqrt(2)*lamda1));

