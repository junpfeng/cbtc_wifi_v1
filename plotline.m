function [xn,yn] = plotline(A, B, step)
x1 = A(1);y1 = A(2);x2 = B(1); y2 = B(2);
k = (y2 - y1)/(x2 - x1);
syms k b
F1 = y1 == k*x1 + b;
F2 = y2 == k*x2 + b;

[k, b] = solve(F1, F2, k, b);
k = eval(k);
b = eval(b);
x10 = min([x1,x2]);
x20 = max([x1,x2]);
xn = x10:0.1:x20;
y = k*xn+b;
%plot(xn,y);hold on;
syms x
F3 = step^2 == x^2 + (k*x)^2;
x = eval(solve(F3, x));
if k >= 0
    x = abs(x(1));
else
    x = -abs(x(1));
end
xn = x1:x:x2;
for i = 1:length(xn)
    yn(i) = k*xn(i)+b;
end
% plot(xn,yn,'o');
end