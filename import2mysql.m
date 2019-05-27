function import2mysql(handles)
% ������Ľ����Ľṹ�壬��Ϊ�˴������ݿ⣬��varlnitial��Ľṹ�壬һ������Ϊ�˽������ݿ⣬һ������֮��ʹ��
%% -----------------���ݽṹ-------------------------------
% -------------------���в���--------------------------------
LineCell = {1, [0, 0], [120, 10],3, [200, 100], [210, 200] };
CircleCell = {2, [120, 10], [200, 100],[140,100], pi/3};
myTrack = struct('TrackX',[0],...    % ������Ե������x��
                 'TrackY',[0],...    % ������Ե������y��
                 'TrackPoint',100,...   % ���Ե�����
                 'TrackN',3,... % ����Ķ�����
                 'Interval',120,...   % ap������m��������mysql�Ĺؼ��֣�����ֱ��ʹ�ã��ĳ�myinterval
                 'Step',20);       % ���沽��m
myTrack.LineCell = LineCell; % ֱ�ӽ�Ԫ����Ϊ�ṹ��Ԫ�ػ��ɽṹ������
myTrack.CircleCell = CircleCell;

myRtx = struct('MatTx',[44.8, 13],...           % AP��������������书��dBm����������dB
               'MatRx',[13, -80, -5],...        % �г����ջ�����:��������dB��������dB����Ƶ������dB����СSIR��
               'ApX',[0],...   % Ŀ��AP������x��
               'ApY',[0],...   % Ŀ��AP������y��
               'signalFre',2e6,...   
               'Threshold',0.02,...   % �ж���ֵ
               'ApRange',[5,13]); % AP������Χ

myInterf = struct('Interf1',[60, 120],... % ���Ż�վ��λ����Ϣ
                  'Interf2',[120, -40],...  
                  'InterfX',[0],...% ��Ÿ��ŵ�1�����������ʽ
                  'InterfY',[0],...% ��Ÿ��ŵ�2�����������ʽ
                  'NoisePower',1,... % ������������dBm
                  'MatTx',[24.8, 24.8]);        % ���Ż�վ�ķ��书�� 
              
myCost = struct('alpha',1,...
                'beta',1,...
                'gama',1);
           
% ------------------�ŵ�ģ��---------------------------------
% ����һ���ŵ�ģ�͵Ĳ��裺����������Ľṹ���У�ע�����ź�ģ�ͽṹ�壬�������ź�ģ�ͺ������ź�ģ�͵Ĳ���������
myPlain = struct('Chnmod',@LogDistancePLSF,...
                 'Refer',1,... % �ο�����
                 'Exp',3,...
                 'VarInterf1',2.75,... % �����κεĹ��ģ�ͣ�����������Ӱ˥��
                 'VarInterf2',2.75,... % �������Ը��ŵķ���
                 'VarAp',2.75); % ��������AP���źŵķ���
% ����һ���ŵ�ģ��
myMountain = struct('Chnmod',@OtherPLSF,...
                    'Refer',1,... % �ο�����
                    'Exp',3,...
                    'VarInterf1',2.75,... % �����κεĹ��ģ�ͣ�����������Ӱ˥��
                    'VarInterf2',2.75,...
                    'VarAp',2.75);
                
% ---------�ⲿ����ĳ����ĳ�ʼ��-----------------------------             
myImport = struct('Chnmod',@ImportPLSF,...
                    'Refer',1,... % �ο�����
                    'Exp',3,...
                    'VarInterf1',[],... % ���Ե�һ�����ŵĸ��Ź���
                    'VarInterf2',[],... % ���Եڶ������ŵĸ��Ź���
                    'VarAp',2.75,...
                    'Index',0,...
                    'Sum',0);            
%  ����python������              
import py.file_parse.*;
myImport.VarInterf1 = cellfun(@double, cell(file_parse("T1rec.txt")));
myImport.VarInterf2 = cellfun(@double, cell(file_parse("T2rec.txt")));                
myImport.Sum = length(myImport.VarInterf1); % ����
% -------------------------------------------------------------------------------                      
                
% ��ӻ����޸ĳ���              
mySceneMod = struct('Plain',myPlain,...     % ÿ�ֳ����Ĵ���취
                 'Mountain',myMountain,...
                 'Urban',myPlain,...
                 'Tunnel',myPlain,...
                 'Import',myImport);
myScene = struct('mySceneMod',mySceneMod,...
                 'myCurrentScene','ƽԭ',...
                 'myCurrentMod',myPlain); % ��ǰѡ��ĳ���
myScene.mySceneLib = {'ƽԭ','ɽ��','����','���', '�ⲿ����'}; % ����ע��
%------------����ľ��������ṹ��---------------------------------------
% ����Ƿ�������Ҫ�����Ժͱ����ṹ�壬�����ص����ڣ�һ�������ݴ�������ɣ�֮��ĵ��ò����ٽ����޸ģ������ӣ��������α�����ã���߳���Ч��                            
myObject = struct('myTrack',myTrack,... % ����ṹ��
                  'myRtx',myRtx,...    % AP����ջ��ṹ��
                   'myInterf',myInterf,... % ���Žṹ��
                   'myCost',myCost,...     % ���ۺ����ṹ��%                   'myChnmod',myChnmod,...
                   'myScene',myScene);     % ����ģ�ͽṹ��    
              
% �����ṹ�壬���������Ҫ�ı�ı����ȵ�
OptMeanPower = struct('M0',[0],...  % ������������ŵ�ģ�ͼ�����źž�ֵ����ͬ�����ŷ����£�Ŀ��AP�ľ�ֵ����,
                      'M1',[0],...  % ���ŷ����£�����1�ľ�ֵ����
                      'M2',[0],...  % ���ŷ����£�����2�ľ�ֵ����
                      'Var0',[0],...
                      'Var1',[0],...
                      'Var2',[0])
Distance = struct('ApDis',[0],...    % ��Ŀ��AP֮��ľ���
                  'Interf1Dis',[0],...  % �����1֮��ľ���
                  'Interf2Dis',[0]);    % �����2֮��ľ���                
myEventdata = struct('OptMeanPower',OptMeanPower,... % ���Ž��½��յ������źŵľ�ֵdBm
                     'Distance',Distance,...    % ���Ե����Ŀ��AP������1�͸���2�ľ���
                     'ApM',1,...   % ���AP������������ʱ����                  
                     'ApCell',{0},...
                     'pOut2',[0],...
                     'OptDeploy',{0},... % ���Ų��𷽰���AP����
                     'OptPosition',[0],...   % ���Ų��������з����еĵڼ���
                     'MeanOut',[0],...   %���п��ܸ��Ե�ƽ���жϸ���
                     'MaxOut',[0],...    %���п��ܸ��Ե�����жϸ���
                     'Cost',[0],... % ���Ų���Ĵ���
                     'IsOpt',[0]);  % �Ƿ�������Ž�ı�־λ 1���ڣ�0������
%                      'CellScene',{'ƽԭ','����','���','ɽ��'},...
%                      'StringScene','ƽԭ'... % �������UI��ѡ��
%% ���ݵ�Ԥ����---�ǳ���Ҫ
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
%---------------��ȡ�������----------------------------
% threshold = str2double(get(handles.rec_table,'Data')); 
% threshold = threshold(3);
[myObject.myTrack.TrackN, tracktmp] = size(get(handles.track_table,'Data')); % ��ά�����length��������

myObject.myInterf.NoisePower = 1;
% myObject.myTrack.Interval = str2double(get(handles.interval_edit,'String'));
myObject.myRtx.Threshold = str2double(get(handles.threshold_edit,'String'));
%% -----------configuration of track------------
LineCell = {}; CircleCell = {};
track_data = get(handles.track_table,'Data');
% ----���ڿ��Լ�һ������Ϊ��ʱ���쳣����(������ʽ)-----
for i = 1:myObject.myTrack.TrackN
    if track_data{i} == 'ֱ����'
        [x1,y1] = coordinate2xy(track_data{i,2}); [x2,y2] = coordinate2xy(track_data{i,3});
        x1 = str2double(x1);x2 = str2double(x2);y1 = str2double(y1);y2 = str2double(y2);
        LineCell = [LineCell, {i, [x1, y1], [x2, y2]}];
    elseif track_data{i} == 'Բ����'
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
myObject.myScene.myCurrentScene = get(handles.SceneMenu,'String'); % ��ȡ��ǰ����
myScene_num = get(handles.SceneMenu, 'value');
myObject.myScene.myCurrentScene = myObject.myScene.myCurrentScene{myScene_num};
% myObject.myScene.myCurrentScene = myObject.myScene.myCurrentScene{1};
%%------------------parameter of the path loss----------------------------
% myObject.my = str2double(get(handles.exp_edit,'String')); d0 = str2double(get(handles.refer_edit,'String'));
% K = 900;                          -----------------��һ�����ɳ�������-------------------
% pathl = {n, d0, K};
%%------------------parameter of the shadowing fade------------------------------
% sgma0 = str2double(get(handles.var0_edit,'String'));
% sgma1 = str2double(get(handles.var1_edit,'String'));
% sgma2 = str2double(get(handles.var2_edit,'String'));
% shadowf = {sgma0, sgma1, sgma2};  -----------------��һ�����ɳ�������-------------------
% 
% ��ȡĿ��AP�͹�����Ե������ Step, Interval, LineCell, CircleCell,N
% [myObject, myEventdata] = get_track(myObject, myEventdata);

% ���Ե������
% myObject.myTrack.TrackPoint = length(myObject.myTrack.TrackX);

% ����mysql
save2mysql(myObject, myEventdata);

end