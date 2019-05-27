function [myObject,myEventdata] = get_track(myObject, myEventdata)
% 函数用来计算并返回轨道步长测试点坐标和AP坐标
% 输入时 步长、AP间隔、直线段、弧段、段数(总共有几段轨道拼接的)。
% 输出 步长测试点坐标和AP的坐标
           % 起点、终点 
Step = myObject.myTrack.Step;
Interval = myObject.myTrack.Interval;
LineCell = myObject.myTrack.LineCell;
CircleCell = myObject.myTrack.CircleCell;
N = myObject.myTrack.TrackN;           
           
           
LineLen = length(LineCell);
        % 固定格式，用5个元素来描述一个弧，弧的数量是5的倍数
CircleLen = length(CircleCell);
X = {};
Y = {};
% 预分配内存
X = cell(1, N); Y = cell(1, N);
for i = 1:3:LineLen
    index = uint8(LineCell{i});
    A = LineCell{i + 1};
    B = LineCell{i + 2};
    [xl, yl] = plotline(A ,B, Step);
    X{index} = xl; Y{index} = yl;
    xl = 0; yl = 0;
end
for i = 1:5:CircleLen
    index = uint8(CircleCell{i});
    A = CircleCell{i + 1};
    B = CircleCell{i + 2};
    O = CircleCell{i + 3};
    degree = CircleCell{i + 4};
    [xc, yc] = plotcircle(A ,B, O, degree, Step);
    X{index} = xc; Y{index} = yc;
    xc = 0; yc = 0;
end
X = unique(cell2mat(X)); 
%Y = unique(cell2mat(Y)); % 为什么要用 unique
Y = cell2mat(Y);
apx = X(1:Interval/Step:length(X));
apy = Y(1:Interval/Step:length(Y)); 
%plot(X, Y, 'x');  % 步点坐标 
%plot(apx, apy, 'O');  % AP坐标

track_x = X; track_y = Y;
ap_x = apx; ap_y = apy;
% 至此为止，X和Y中依次存放了轨道所有可能的暴力搜索点的坐标，之后只需要取遍历这个坐标来计算中断即可。
myObject.myTrack.TrackX = track_x;
myObject.myTrack.TrackY = track_y;
myObject.myRtx.ApX = ap_x;
myObject.myRtx.ApY = ap_y;


end

