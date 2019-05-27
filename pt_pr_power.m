function [m] = pt_pr_power(pt,gt,gr,n,d,d0,fc)   
%UNTITLED 计算接收机接收到的信号均值
%   接收机的 均值 是和 发射机的均值 以及 路径长度 有关的
%   输入：发射机的发射功率pt(dBm)，发射增益gt，接受增益gr，路径损耗指数n，
%         路径损耗增益k，接收机与发射机之间的距离deta_d，参考距离d0
%         （载波频率 fc，目前不确定 。          ）
%   输出：接收机的接收到的信号的均值
%   常规的参数：发射功率10dBm,发射增益10dB，接受增益10dB,路径损耗指数3，路径损耗增益(按照范平志的ppt计算)
if nargin <= 6  %fc设为缺省值
    fc = 2.4e6; 
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%路径损耗增益
    m = pt+gt+gr-10*n*log10(abs(d)/d0)+10*log10(k);  %由公式可得
    %   q = q;标准差不变
end
end

