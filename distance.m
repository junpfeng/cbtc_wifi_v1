function d = distance(a, b, F, x)
% a��b�����������꣬�ǰ�������Ԫ�ص�����
% F�����߷��̣���һ�����ű��ʽ
% x�Ƿ��ű��ʽ�еķ��ű�������д������£�Ĭ�Ϸ��ű���Ϊx
    if nargin == 2 % ��������֮���ֱ�߾���
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