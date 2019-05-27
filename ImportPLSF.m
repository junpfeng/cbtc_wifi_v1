function [M0, M1, M2] = ImportPLSF(myObject,myEventdata)
% 说明：信道模型函数
%UNTITLED5 此处显示有关此函数的摘要
% 返回接收到的目标AP、干扰1、干扰2的均值
%   此处显示详细说明
fc = 2.4e9;
% R = myObject.myRtx.MatRx{3};    % 接收机最小要求的信干比
pt0 = myObject.myRtx.MatTx(1); gt0 = myObject.myRtx.MatTx(2); % 目标AP的发射功率
pt1 = myObject.myInterf.MatTx(1);  % 干扰基站的发射功率
pt2 = myObject.myInterf.MatTx(2); 
gt1 = 0; gt2 = 0;   % 把发射增益放到发射功率里
gr = myObject.myRtx.MatRx(1);   % 接受增益

n = myObject.myScene.myCurrentMod.Exp; % 信道模型的指数
d0 = myObject.myScene.myCurrentMod.Refer; % 信道模型参考距离

%% ----------来自目标AP的均值
ApDis = myEventdata.Distance.ApDis; % 此时测试点与目标AP的距离
if ApDis < 1, ApDis = 1; end
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%路径损耗增益
    M0 = pt0+gt0+gr-10*n*log10(abs(ApDis)/d0)+10*log10(k);  %由公式可得
    %   q = q;标准差不变

%% ----------来自干扰1的均值
Index = myObject.myScene.myCurrentMod.Index;
Sum = myObject.myScene.myCurrentMod.Sum;
if (Index > Sum)
    Index = Sum;
end 
M1 = myObject.myScene.myCurrentMod.VarInterf1(Index);     
%% --------来自干扰2的均值

M2 = myObject.myScene.myCurrentMod.VarInterf2(Index);    
end
    

    

