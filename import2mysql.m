function import2mysql(handles)
% 这下面的建立的结构体，是为了存入数据库，而varlnitial里的结构体，一方面是为了接受数据库，一方面是之后使用
%% -----------------数据结构-------------------------------
% -------------------固有参数--------------------------------
LineCell = {1, [0, 0], [120, 10],3, [200, 100], [210, 200] };
CircleCell = {2, [120, 10], [200, 100],[140,100], pi/3};
myTrack = struct('TrackX',[0],...    % 轨道测试点的坐标x轴
                 'TrackY',[0],...    % 轨道测试点的坐标y轴
                 'TrackPoint',100,...   % 测试点数量
                 'TrackN',3,... % 轨道的段数。
                 'Interval',120,...   % ap部署间隔m，这是是mysql的关键字，不能直接使用，改成myinterval
                 'Step',20);       % 仿真步长m
myTrack.LineCell = LineCell; % 直接将元组作为结构体元素会变成结构体数组
myTrack.CircleCell = CircleCell;

myRtx = struct('MatTx',[44.8, 13],...           % AP发射机参数：发射功率dBm、天线增益dB
               'MatRx',[13, -80, -5],...        % 列车接收机参数:接受增益dB、灵敏度dB、射频保护比dB（最小SIR）
               'ApX',[0],...   % 目标AP的坐标x轴
               'ApY',[0],...   % 目标AP的坐标y轴
               'signalFre',2e6,...   
               'Threshold',0.02,...   % 中断阈值
               'ApRange',[5,13]); % AP数量范围

myInterf = struct('Interf1',[60, 120],... % 干扰基站的位置信息
                  'Interf2',[120, -40],...  
                  'InterfX',[0],...% 存放干扰点1坐标的数组形式
                  'InterfY',[0],...% 存放干扰点2坐标的数组形式
                  'NoisePower',1,... % 加性噪声功率dBm
                  'MatTx',[24.8, 24.8]);        % 干扰基站的发射功率 
              
myCost = struct('alpha',1,...
                'beta',1,...
                'gama',1);
           
% ------------------信道模型---------------------------------
% 建立一个信道模型的步骤：首先在下面的结构体中，注册其信号模型结构体，包括：信号模型函数、信号模型的参数、场景
myPlain = struct('Chnmod',@LogDistancePLSF,...
                 'Refer',1,... % 参考距离
                 'Exp',3,...
                 'VarInterf1',2.75,... % 对于任何的轨道模型，都可以有阴影衰落
                 'VarInterf2',2.75,... % 接受来自干扰的方差
                 'VarAp',2.75); % 接受来自AP的信号的方差
% 其他一种信道模型
myMountain = struct('Chnmod',@OtherPLSF,...
                    'Refer',1,... % 参考距离
                    'Exp',3,...
                    'VarInterf1',2.75,... % 对于任何的轨道模型，都可以有阴影衰落
                    'VarInterf2',2.75,...
                    'VarAp',2.75);
                
% ---------外部导入的场景的初始化-----------------------------             
myImport = struct('Chnmod',@ImportPLSF,...
                    'Refer',1,... % 参考距离
                    'Exp',3,...
                    'VarInterf1',[],... % 来自第一个干扰的干扰功率
                    'VarInterf2',[],... % 来自第二个干扰的干扰功率
                    'VarAp',2.75,...
                    'Index',0,...
                    'Sum',0);            
%  导入python的数据              
import py.file_parse.*;
myImport.VarInterf1 = cellfun(@double, cell(file_parse("T1rec.txt")));
myImport.VarInterf2 = cellfun(@double, cell(file_parse("T2rec.txt")));                
myImport.Sum = length(myImport.VarInterf1); % 数量
% -------------------------------------------------------------------------------                      
                
% 添加或者修改场景              
mySceneMod = struct('Plain',myPlain,...     % 每种场景的处理办法
                 'Mountain',myMountain,...
                 'Urban',myPlain,...
                 'Tunnel',myPlain,...
                 'Import',myImport);
myScene = struct('mySceneMod',mySceneMod,...
                 'myCurrentScene','平原',...
                 'myCurrentMod',myPlain); % 当前选择的场景
myScene.mySceneLib = {'平原','山区','城区','隧道', '外部导入'}; % 场景注册
%------------对外的就这两个结构体---------------------------------------
% 这个是仿真中重要的属性和变量结构体，最大的特点在于，一旦在数据处理部分完成，之后的调用不会再进行修改，这样子，函数传参变成引用，提高程序效率                            
myObject = struct('myTrack',myTrack,... % 轨道结构体
                  'myRtx',myRtx,...    % AP与接收机结构体
                   'myInterf',myInterf,... % 干扰结构体
                   'myCost',myCost,...     % 代价函数结构体%                   'myChnmod',myChnmod,...
                   'myScene',myScene);     % 场景模型结构体    
              
% 保留结构体，用来存放需要改变的变量等等
OptMeanPower = struct('M0',[0],...  % 可以用来存放信道模型计算的信号均值，下同；最优方案下，目标AP的均值集合,
                      'M1',[0],...  % 最优方案下，干扰1的均值集合
                      'M2',[0],...  % 最优方案下，干扰2的均值集合
                      'Var0',[0],...
                      'Var1',[0],...
                      'Var2',[0])
Distance = struct('ApDis',[0],...    % 与目标AP之间的距离
                  'Interf1Dis',[0],...  % 与干扰1之间的距离
                  'Interf2Dis',[0]);    % 与干扰2之间的距离                
myEventdata = struct('OptMeanPower',OptMeanPower,... % 最优解下接收到各个信号的均值dBm
                     'Distance',Distance,...    % 测试点距离目标AP、干扰1和干扰2的距离
                     'ApM',1,...   % 存放AP部署数量的临时变量                  
                     'ApCell',{0},...
                     'pOut2',[0],...
                     'OptDeploy',{0},... % 最优部署方案的AP坐标
                     'OptPosition',[0],...   % 最优部署是所有方案中的第几组
                     'MeanOut',[0],...   %所有可能各自的平均中断概率
                     'MaxOut',[0],...    %所有可能各自的最大中断概率
                     'Cost',[0],... % 最优部署的代价
                     'IsOpt',[0]);  % 是否存在最优解的标志位 1存在，0不存在
%                      'CellScene',{'平原','城区','隧道','山区'},...
%                      'StringScene','平原'... % 用来存放UI的选择
%% 数据的预处理---非常重要
%--------configuration of interferences--------
myObject.myInterf.MatTx(1) = str2double(get(handles.inter1power_edit,'String'));
myObject.myInterf.MatTx(2) = str2double(get(handles.inter2power_edit,'String'));
interx1 = str2double(get(handles.interx1_edit,'String'));
intery1 = str2double(get(handles.intery1_edit,'String'));
interx2 = str2double(get(handles.interx2_edit,'String'));
intery2 = str2double(get(handles.intery2_edit,'String'));
myObject.myInterf.InterfX = [interx1, interx2];
myObject.myInterf.InterfY = [intery1, intery2];
myObject.myInterf.Interf1 = [interx1, intery1];
myObject.myInterf.Interf2 = [interx2, intery2];
%% ----------someother configuration-----------------
% myObject.myTrack.Step = str2double(get(handles.step_edit,'String')); 
% myObject.myCost.alpha = str2double(get(handles.alpha_edit,'String')); 
% myObject.myCost.beta = str2double(get(handles.beta_edit,'String')); 
M1 = str2double(get(handles.num1_edit,'String')); 
M2 = str2double(get(handles.num2_edit,'String')); 
myObject.myRtx.ApRange = [M1, M2];
%---------------读取表的内容----------------------------
% threshold = str2double(get(handles.rec_table,'Data')); 
% threshold = threshold(3);
[myObject.myTrack.TrackN, tracktmp] = size(get(handles.track_table,'Data')); % 二维数组的length是其行数

myObject.myInterf.NoisePower = 1;
% myObject.myTrack.Interval = str2double(get(handles.interval_edit,'String'));
myObject.myRtx.Threshold = str2double(get(handles.threshold_edit,'String'));
%% -----------configuration of track------------
LineCell = {}; CircleCell = {};
track_data = get(handles.track_table,'Data');
% ----后期可以加一个输入为空时的异常处理(弹窗形式)-----
for i = 1:myObject.myTrack.TrackN
    if track_data{i} == '直线型'
        [x1,y1] = coordinate2xy(track_data{i,2}); [x2,y2] = coordinate2xy(track_data{i,3});
        x1 = str2double(x1);x2 = str2double(x2);y1 = str2double(y1);y2 = str2double(y2);
        LineCell = [LineCell, {i, [x1, y1], [x2, y2]}];
    elseif track_data{i} == '圆弧型'
        [x1,y1] = coordinate2xy(track_data{i,2}); [x2,y2] = coordinate2xy(track_data{i,3});
        x1 = str2double(x1);x2 = str2double(x2);y1 = str2double(y1);y2 = str2double(y2);
        [xo,yo] = coordinate2xy(track_data{i,4}); degree = str2double(track_data{i,5});
        xo = str2double(xo);yo = str2double(yo); degree = degree./360*2*pi;
        CircleCell = [CircleCell, {i, [x1, y1], [x2, y2], [xo, yo], degree}];
    end
end
myObject.myTrack.CircleCell = CircleCell;
myObject.myTrack.LineCell = LineCell;
%% -----------------configuration of the ap-------------------------
pgt = get(handles.AP_table,'Data'); 
% pt0 = str2double(pt0{1});
% gt0 = get(handles.AP_table,'Data'); 
% gt0 = str2double(gt0{2});
myObject.myRtx.MatTx(1) = str2double(pgt{1});
myObject.myRtx.MatTx(2) = str2double(pgt{2});
%% ------------------configuration of the receiver------------------------------
% Grx = get(handles.rec_table,'Data'); Grx = str2double(Grx{1});
% R = get(handles.rec_table,'Data'); R = str2double(R{3});
% Sm = get(handles.rec_table,'Data'); Sm = str2double(Sm{2});
res = get(handles.rec_table,'Data');
myObject.myRtx.MatRx = [str2double(res{1}), str2double(res{2}), str2double(res{3})];
%% ------------------Scene and Chnmod-----------------------------
myObject.myScene.myCurrentScene = get(handles.SceneMenu,'String'); % 获取当前场景
myScene_num = get(handles.SceneMenu, 'value');
myObject.myScene.myCurrentScene = myObject.myScene.myCurrentScene{myScene_num};
% myObject.myScene.myCurrentScene = myObject.myScene.myCurrentScene{1};
%%------------------parameter of the path loss----------------------------
% myObject.my = str2double(get(handles.exp_edit,'String')); d0 = str2double(get(handles.refer_edit,'String'));
% K = 900;                          -----------------这一部分由场景决定-------------------
% pathl = {n, d0, K};
%%------------------parameter of the shadowing fade------------------------------
% sgma0 = str2double(get(handles.var0_edit,'String'));
% sgma1 = str2double(get(handles.var1_edit,'String'));
% sgma2 = str2double(get(handles.var2_edit,'String'));
% shadowf = {sgma0, sgma1, sgma2};  -----------------这一部分由场景决定-------------------
% 
% 获取目标AP和轨道测试点的坐标 Step, Interval, LineCell, CircleCell,N
% [myObject, myEventdata] = get_track(myObject, myEventdata);

% 测试点的数量
% myObject.myTrack.TrackPoint = length(myObject.myTrack.TrackX);

% 存入mysql
save2mysql(myObject, myEventdata);

end