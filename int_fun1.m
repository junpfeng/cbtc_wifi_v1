function f = int_fun1(x,lamda0,lamda1,tao)
%UNTITLED �����еĵ�һ����������
%   �˴���ʾ��ϸ˵��
    f = exp(-x.^2).*erfc((lamda0/lamda1)*x+tao/(sqrt(2)*lamda1));

