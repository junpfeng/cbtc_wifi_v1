function [myObject,myEventdata] = cost(myObject, myEventdata)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
% input AP_cell������AP�Ĳ���Ŀ����� pout2��sir����������Ƕ�Ӧ�ģ�M�ǲ���AP������
% output Cn�����Ż���AP��������, locat�Ǳ�ʾ�ڼ�������

ApCell = myEventdata.ApCell;
ApM = myEventdata.ApM;
pOut2 = myEventdata.pOut2;
alpha = myObject.myCost.alpha; 
beta = myObject.myCost.beta; 

pOut2 = pOut2';
Mean = mean(pOut2);
Max = max(pOut2);

% �����ǰ���𷽰��£��жϸ������ֵ����С�Ķ�����ֵҪ����˵�����鷽��ȫ�����
if min(Max) > myObject.myRtx.Threshold
    return 
end

C = alpha*(Mean.*10^3).^2 + beta*(Max.*10^3).^2 + ApM^2;
locat = find(C == min(C));
% Ԥ�����ڴ�
Cn = cell(1,ApM);

for i = 1 : ApM
    Cn{i} = ApCell{locat,i};
end

% ������ѵĲ����£��г����ܵ����Ի�վ�͸��ŵ��źž�ֵ�б�
myEventdata.OptMeanPower.M0 = myEventdata.OptMeanPower.M0(locat, :); % ����ṹ��
myEventdata.OptMeanPower.M1 = myEventdata.OptMeanPower.M1(locat, :); % ����ṹ��
myEventdata.OptMeanPower.M2 = myEventdata.OptMeanPower.M2(locat, :); % ����ṹ��

myEventdata.IsOpt = 1; % �ҵ����Ų����־λ��
myEventdata.OptDeploy = Cn;
myEventdata.OptPosition = locat;
myEventdata.MeanOut = Mean;
myEventdata.MaxOut = Max;
myEventdata.Cost = C;       
end
