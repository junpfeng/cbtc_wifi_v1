function [myObject, myEventdata] = outage_vaildate(myObject, myEventdata)
%UNTITLED input 目标信号均值序列、两个干扰信号均值序列、中断概率的阈值
% 信干比 = 有用信号功率/干扰信号（不是白噪声干扰，而是特定的干扰信号）功率
% 信干比 = 目标信号均值/干扰信号均值
%   output : 验证的中断概率
%   此处显示详细说明

% 信干比
Sir = myEventdata.OptMeanPower.M0 - (myEventdata.OptMeanPower.M1 - myEventdata.OptMeanPower.M2 + myObject.myInterf.NoisePower);
Outage = 0; % 使用另一种办法统计中断概率
for i = 1:myObject.myTrack.TrackPoint
    if Sir(i) < myObject.myRtx.Threshold
        Outage = Outage + 1;
    end
%% 验证是否存在    
if myEventdata.MaxOut(myEventdata.OptPosition) < myObject.myRtx.Threshold 
    if (Outage/myObject.myTrack.TrackPoint) < myObject.myRtx.Threshold
        myEventdata.IsOpt = 1;
    else
        myEventdata.IsOpt = 1;
    end
end



end

