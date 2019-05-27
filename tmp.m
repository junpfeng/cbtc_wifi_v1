d0 = 1;  n = 3; pt = 30; gt=10;gr = 10; 
d = 10;
fc = 2.4e9; 
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%路径损耗增益
    m = pt+gt+gr-10*n*log10(abs(d)/d0)+10*log10(k)  %由公式可得