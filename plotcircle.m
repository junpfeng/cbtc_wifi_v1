function [xn, yn] = plotcircle(A, B, O, degree, step)
%if nargin == 4
aa = O(1); bb = O(2); % 模糊的圆心坐标
x1 = A(1); y1 = A(2); x2 = B(1); y2 = B(2); theta = degree; % 起点和终点坐标圆弧对应的圆心角
% x1 = 1; y1 = 0; x2 = 0; y2 = 1; theta = pi/2; % 起点和终点坐标圆弧对应的圆心角
% 第一步，由圆心角、起点终点坐标，求圆心坐标、半径
syms a b;
F1 = (x1-a).^2 + (y1-b).^2 == (x2-a).^2 + (y2-b).^2;
F2 = (x1-a).*(x2-a) + (y1-b).*(y2-b) == sqrt((x1-a).^2 + (y1-b).^2).*sqrt((x2-a).^2 + (y2-b).^2).*cos(theta);
anss = solve(F1,F2,a,b);
a = eval(anss.a);b = eval(anss.b);
% 判断哪个是真正的圆心,判断方法是看根和哪个圆心靠的近，因此模糊圆心也需要尽量准确一点，否则还是可能会判断出错
if ((a(1)-aa)^2+(b(1)-bb)^2)<=((a(2)-aa)^2+(b(2)-bb)^2) 
    a = a(1); b = b(1);
else
    a = a(2); b = b(2);
end
% 求起点和终点和x轴的角度
alpha=[(x1-a),(y1-b)]; beta=[(x2-a),(y2-b)]; gama = [1,0]; % 向量
r = sqrt(alpha(1)^2+alpha(2)^2);
theta0 = acos( sum(alpha.*gama)./sqrt(alpha(1)^2+alpha(2)^2)*sqrt(gama(1)^2+gama(2)^2));
theta1 = acos( sum(gama.*beta)./sqrt(beta(1)^2+beta(2)^2)*sqrt(gama(1)^2+gama(2)^2)) ;
% 判断(x1,y1)圆心角的正负
if alpha(1) >= 0 && alpha(2) >= 0
    theta0 = abs(theta0); 
elseif alpha(1) <= 0 && alpha(2) >= 0
    theta0 = abs(theta0); 

elseif alpha(1) <= 0 && alpha(2) <= 0
    theta0 = -(theta0); 

else
    theta0 = -(theta0); 

end
% 判断(x2,y3)圆心角的正负
if beta(1) >= 0 && beta(2) >= 0

    theta1 = abs(theta1);
elseif beta(1) <= 0 && beta(2) >= 0

    theta1 = abs(theta1);
elseif beta(1) <= 0 && beta(2) <= 0

    theta1 = -(theta1);
else

    theta1 = -(theta1);
end      

% 求出圆弧方程，并画出来。

thet0 = min([theta0 theta1]);
thet1 = max([theta0 theta1]);

% theta = thet0:0.01:thet1;
% x = r*cos(theta)+a; % 这段验证是否可以拼一个圆
% y = r*sin(theta)+b;
% plot(x,y); hold on;

if thet1 - thet0 >= pi
    thet0 = thet0 + 2*pi;
theta = thet1:0.01:thet0;
else
    theta = thet0:0.01:thet1;
end
x = r*cos(theta)+a;
y = r*sin(theta)+b;
%plot(x,y);hold on;
detatheta = step/r;
i=1;
for thetan = thet0:detatheta:thet1
    xn(i) = r*cos(thetan)+a;
    yn(i) = r*sin(thetan)+b;
    i=i+1;
end
% plot (xn,yn, 'o');
end





