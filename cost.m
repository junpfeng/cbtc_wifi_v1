function [myObject,myEventdata] = cost(myObject, myEventdata)
%UNTITLED 此处显示有关此函数的摘要
% input AP_cell是所有AP的部署的可能性 pout2和sir里面的内容是对应的；M是部署AP的数量
% output Cn是最优化的AP部署坐标, locat是表示第几组最优

ApCell = myEventdata.ApCell;
ApM = myEventdata.ApM;
pOut2 = myEventdata.pOut2;
alpha = myObject.myCost.alpha; 
beta = myObject.myCost.beta; 

pOut2 = pOut2';
Mean = mean(pOut2);
Max = max(pOut2);

% 如果当前部署方案下，中断概率最大值中最小的都比阈值要大，那说明这组方案全部否决
if min(Max) > myObject.myRtx.Threshold
    return 
end

C = alpha*(Mean.*10^3).^2 + beta*(Max.*10^3).^2 + ApM^2;
locat = find(C == min(C));
% 预分配内存
Cn = cell(1,ApM);

for i = 1 : ApM
    Cn{i} = ApCell{locat,i};
end

% 导入最佳的部署下，列车接受的来自基站和干扰的信号均值列表
myEventdata.OptMeanPower.M0 = myEventdata.OptMeanPower.M0(locat, :); % 导入结构体
myEventdata.OptMeanPower.M1 = myEventdata.OptMeanPower.M1(locat, :); % 导入结构体
myEventdata.OptMeanPower.M2 = myEventdata.OptMeanPower.M2(locat, :); % 导入结构体

myEventdata.IsOpt = 1; % 找到最优部署标志位。
myEventdata.OptDeploy = Cn;
myEventdata.OptPosition = locat;
myEventdata.MeanOut = Mean;
myEventdata.MaxOut = Max;
myEventdata.Cost = C;       
end
