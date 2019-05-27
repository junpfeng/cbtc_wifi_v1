function [myObject,myEventdata] = bf_search(myObject, myEventdata)
% 只要不对输入参数进行改变，那么就是引用传递，不会因为参数较大而影响效率
% 输入是 AP里面是AP的横坐标集合，纵坐标集合，发射功率和增益
% 输出是 Cn,m0、m1、m2分别是目标AP和两个基站的干扰信号的均值功率
% 必须从所有可能的AP部署点中选择几个点来部署AP
for i_ = myObject.myRtx.ApRange(1):myObject.myRtx.ApRange(2);
myEventdata.ApM = i_;  % 当前运行布置的AP的数量 
M = i_;
alpha = myObject.myCost.alpha; % 代价因子 
beta = myObject.myCost.alpha;  % 代价因子 

ApCell = ap_deploy(myObject.myRtx.ApX, myObject.myRtx.ApY, myEventdata.ApM); % AP部署的所有可能
myEventdata.ApCell = ApCell;    % 导入结构体
ApNum = length(ApCell); % 一共AP_num种方案
TrackPointNum = myObject.myTrack.TrackPoint; % 轨道测试点数量
Interf1 = myObject.myInterf.Interf1;
Interf2 = myObject.myInterf.Interf2;
TrackX = myObject.myTrack.TrackX;
TrackY = myObject.myTrack.TrackY;

% 预分配内存
m0 = zeros(ApNum, TrackPointNum); m1 = zeros(ApNum, TrackPointNum); m2 = zeros(ApNum, TrackPointNum); % 存放均值
pOut2 = zeros(ApNum, TrackPointNum); % 存放中断概率
ApDis = zeros(1,M);    % 所有AP到轨道测试点的距离，之后转为目标AP到测试点的距离

for type = 1:ApNum % 对于每一种AP部署方案
%% 遍历
    for i = 1:TrackPointNum % 遍历整个轨道i就是沿轨道的距离
        % 由距离反解步点坐标
        %  计算步点与干扰之间的距离
        Interf1Dis = distance(Interf1 ,[TrackX(i), TrackY(i)]); %第一个干扰与火车的距离
        Interf2Dis = distance(Interf2 ,[TrackX(i), TrackY(i)]); %第二个干扰与火车的距离
        % 使用比较法判断哪个是目标AP
        for j = 1:M % 对于每一种AP部署方案的每一个测试点，对每个AP测距,M表示一直部署方案下的AP数量 
            ApDis(j) = distance([TrackX(i), TrackY(i)], [cell2mat(ApCell(type, j))]);
        end
        ApDis = min(ApDis); % 其中最小距离为目标AP与列车的距离
        % 计算中断概率
        myEventdata.Distance.ApDis = ApDis;
        myEventdata.Distance.Interf1Dis = Interf1Dis;
        myEventdata.Distance.Interf2Dis = Interf2Dis;
        
        % 传入接受干扰功率的索引i
        myObject.myScene.myCurrentMod.Index = i;
        
        [pOut2(type, i), m0(type, i), m1(type, i), m2(type, i)] = outage2_p(myObject, myEventdata);
        
        
%         ii = ii + 1;
    end
end
myEventdata.pOut2 = pOut2; % 导入结构体
myEventdata.OptMeanPower.M0 = m0; % 导入结构体
myEventdata.OptMeanPower.M1 = m1; % 导入结构体
myEventdata.OptMeanPower.M2 = m2; % 导入结构体

    % 计算代价，求解最优解
    [myObject,myEventdata] = cost(myObject,myEventdata);
    
    % 上面的cost找到了最优部署就退出暴力搜索，否则继续暴力
    if myEventdata.IsOpt == 1
        myEventdata.IsOpt = 0;
        break;
    end
%     m00 = m0(locat,:);
%     m11 = m1(locat,:);
%     m22 = m2(locat,:);
end
