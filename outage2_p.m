function [Pout2, m0, m1, m2] = outage2_p(myObject,myEventdata)
%   ���룺��Ŀ��AP���롢�������ŵ�ľ��룻·����Ĳ�������Ӱ˥�����,���ջ�����
%   
%   ��������ֵ���������ŵ���жϸ��� 
%
% ������յ����źž�ֵ
%% ===================������Եľ�ֵ====================
%**********���������������ڲ������ܸ����źŵĹ���******************
[myEventdata.OptMeanPower.M0, myEventdata.OptMeanPower.M1, myEventdata.OptMeanPower.M2] = myObject.myScene.myCurrentMod.Chnmod(myObject,myEventdata);
m0 = myEventdata.OptMeanPower.M0;
m1 = myEventdata.OptMeanPower.M1;
m2 = myEventdata.OptMeanPower.M2;
%% �����ֽ�
% (interf, AP, ia_dis, pathl, shadowf, rec)
sgma0 = myObject.myScene.myCurrentMod.VarAp; % Ŀ��AP�ķ���
sgma1 = myObject.myScene.myCurrentMod.VarI1; sgma2 =myObject.myScene.myCurrentMod.VarI2; % ���ŵ�ķ��� 
Sm = myObject.myRtx.MatRx(2);   % ���ջ�������
R = myObject.myRtx.MatRx(3);    % ���ջ���СҪ����Ÿɱ�
% pt0 = myObject.myRtx.MatTx{1}; gt0 = myObject.myRtx.MatTx{2}; 
% pt1 = myObject.myInterf.MatTx{1};  % ���Ż�վ�ķ��书��
% pt2 = myObject.myInterf.MatTx{2}; 
% gt1 = 0; gt2 = 0;   % �ѷ�������ŵ����书����
% 
% n = myObject.myScene.myCurrentScene.Exp; % �ŵ�ģ�͵�ָ��
% d0 = myObject.myScene.myCurrentScene.Refer; % �ŵ�ģ�Ͳο�����
% 
% ApDis = myEventdata.Distance.ApDis; % ��ʱ���Ե���Ŀ��AP�ľ���
% Interf1Dis = myEventdata.Distance.Interf1Dis;   % ����Ż�վ1�ľ���
% Interf2Dis = myEventdata.Distance.Interf2Dis;   % ����Ż�վ2�ľ���
% 
% gr = myObject.myRtx.MatRx{1};   % ��������

%% ��������
%=======���ű���=======
syms u1 v u3;
%====ͬʱ���й����жϸ����кܶ��ϵ�ܻ���==========
alpha=m0-Sm;
tao=m0-(m1+R);
tao1=m0-(m2+R);
z1=10*log10(10.^((sqrt(2)*sgma0*v+tao)/10)-10.^((sqrt(2)*sgma1*u3)/10))-tao+tao1;
%% ���ʽ
%=================��������ʽ==========================
Pout2_1=(1/2)*erfc(alpha/(sqrt(2)*sgma0));%ʽ�ӵĵ�һ��
% Pout2_2=exp(-u1.^2)*erfc((lamda0/lamda1)*u1+tao/(sqrt(2)*lamda1));%ʽ�ӵĵڶ���ı�������
% Pout2_3_1=exp(-v.^2);               %ʽ�ӵĵ�����ĵ�һ����������
% Pout2_3_2=exp(-u3.^2)*erfc(z1/(sqrt(2)*lamda2));%ʽ�ӵĵ�����ĵڶ�����������
%=================�����ޱ��ʽ==========================
Pout2_2_down = (-alpha)/(sqrt(2)*sgma0);
Pout2_2_up =   inf;%+inf;
Pout2_3_1_down = (-alpha)/(sqrt(2)*sgma0);
Pout2_3_1_up = 700;%+inf;
Pout2_3_2_down = -700;%-inf;
% Pout2_3_2_up = (lamda0/lamda1)*v + tao/(sqrt(2)*lamda1); %���޻����޲����ñ���������Ҫ�ô�v��ʽ��
%=====================����=============================
%��������ʱ������ĩ�� ...
Pout2 = Pout2_1 ...
     + (1/(2*sqrt(pi)))*integral(@(x)int_fun1(x,sgma0,sgma1,tao),Pout2_2_down,Pout2_2_up)...
     + (1/(2*pi))*integral2(@(v,u3)int_fun2(u3,v,sgma0,tao,tao1,sgma1,sgma2),Pout2_3_1_down,Pout2_3_1_up...
       ,Pout2_3_2_down,@(v)((sgma0/sgma1)*v + tao/(sqrt(2)*sgma1)));

end

  


