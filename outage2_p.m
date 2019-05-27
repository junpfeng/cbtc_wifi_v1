function [Pout2, m0, m1, m2] = outage2_p(myObject,myEventdata)
%   输入：是目标AP距离、两个干扰点的距离；路径损耗参数、阴影衰落参数,接收机参数
%   
%   函数返回值：两个干扰点的中断概率 
%
% 计算接收到的信号均值
%% ===================计算各自的均值====================
%**********好像就是这条语句在操作接受干扰信号的功率******************
[myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = myObject.myScene.myCurrentMod.Chnmod(myObject,myEventdata);
m0 = myEventdata.OptMeanPower.M0;
m1 = myEventdata.OptMeanPower.M1;
m2 = myEventdata.OptMeanPower.M2;
%% 参数分解
% (interf, AP, ia_dis, pathl, shadowf, rec)
sgma0 = myObject.myScene.myCurrentMod.VarAp; % 目标AP的方差
sgma1 = myObject.myScene.myCurrentMod.VarI1; sgma2 =myObject.myScene.myCurrentMod.VarI2; % 干扰点的方差 
Sm = myObject.myRtx.MatRx(2);   % 接收机灵敏度
R = myObject.myRtx.MatRx(3);    % 接收机最小要求的信干比
% pt0 = myObject.myRtx.MatTx{1}; gt0 = myObject.myRtx.MatTx{2}; 
% pt1 = myObject.myInterf.MatTx{1};  % 干扰基站的发射功率
% pt2 = myObject.myInterf.MatTx{2}; 
% gt1 = 0; gt2 = 0;   % 把发射增益放到发射功率里
% 
% n = myObject.myScene.myCurrentScene.Exp; % 信道模型的指数
% d0 = myObject.myScene.myCurrentScene.Refer; % 信道模型参考距离
% 
% ApDis = myEventdata.Distance.ApDis; % 此时测试点与目标AP的距离
% Interf1Dis = myEventdata.Distance.Interf1Dis;   % 与干扰基站1的距离
% Interf2Dis = myEventdata.Distance.Interf2Dis;   % 与干扰基站2的距离
% 
% gr = myObject.myRtx.MatRx{1};   % 接受增益

%% 参数定义
%=======符号变量=======
syms u1 v u3;
%====同时文中关于中断概率有很多关系很混乱==========
alpha=m0-Sm;
tao=m0-(m1+R);
tao1=m0-(m2+R);
z1=10*log10(10.^((sqrt(2)*sgma0*v+tao)/10)-10.^((sqrt(2)*sgma1*u3)/10))-tao+tao1;
%% 表达式
%=================函数项表达式==========================
Pout2_1=(1/2)*erfc(alpha/(sqrt(2)*sgma0));%式子的第一项
% Pout2_2=exp(-u1.^2)*erfc((lamda0/lamda1)*u1+tao/(sqrt(2)*lamda1));%式子的第二项的被积函数
% Pout2_3_1=exp(-v.^2);               %式子的第三项的第一个被积函数
% Pout2_3_2=exp(-u3.^2)*erfc(z1/(sqrt(2)*lamda2));%式子的第三项的第二个被积函数
%=================积分限表达式==========================
Pout2_2_down = (-alpha)/(sqrt(2)*sgma0);
Pout2_2_up =   inf;%+inf;
Pout2_3_1_down = (-alpha)/(sqrt(2)*sgma0);
Pout2_3_1_up = 700;%+inf;
Pout2_3_2_down = -700;%-inf;
% Pout2_3_2_up = (lamda0/lamda1)*v + tao/(sqrt(2)*lamda1); %变限积分限不能用变量，而是要用带v的式子
%=====================整合=============================
%换行输入时，在行末加 ...
Pout2 = Pout2_1 ...
     + (1/(2*sqrt(pi)))*integral(@(x)int_fun1(x,sgma0,sgma1,tao),Pout2_2_down,Pout2_2_up)...
     + (1/(2*pi))*integral2(@(v,u3)int_fun2(u3,v,sgma0,tao,tao1,sgma1,sgma2),Pout2_3_1_down,Pout2_3_1_up...
       ,Pout2_3_2_down,@(v)((sgma0/sgma1)*v + tao/(sqrt(2)*sgma1)));

end

  


