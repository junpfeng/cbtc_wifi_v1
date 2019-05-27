function [myObject, myEventdata] = varInitial()
%% -----------------���ݽṹ-------------------------------
% -------------------���в���--------------------------------
LineCell = {1, [0, 0], [120, 10],3, [200, 100], [210, 200] };
CircleCell = {2, [120, 10], [200, 100],[140,100], pi/3};
myTrack = struct('TrackX',[],...    % ������Ե������x��
                 'TrackY',[],...    % ������Ե������y��
                 'TrackPoint',100,...   % ���Ե�����
                 'TrackN',3,... % ����Ķ�����
                 'Interval',180,...   % ap������m��������mysql�Ĺؼ��֣�����ֱ��ʹ�ã��ĳ�myinterval
                 'Step',5);       % ���沽��m
myTrack.LineCell = LineCell;
myTrack.CircleCell = CircleCell;

myRtx = struct('MatTx',[24.8, 13],...           % AP��������������书��dBm����������dB
               'MatRx',[13, -80, -5],...        % �г����ջ�����:��������dB��������dB����Ƶ������dB����СSIR��
               'ApX',[0],...   % Ŀ��AP������x��in
               'ApY',[0],...   % Ŀ��AP������y��
               'signalFre',2e6,...   
               'Threshold',0.02,...   % �ж���ֵ
               'ApRange',[1,3]); % AP������Χ

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
                    'VarI1',2.75,...
                    'VarI2',2.75,...
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
                 'Import', myImport);
myScene = struct('mySceneMod',mySceneMod,...
                 'myCurrentScene','ƽԭ',...
                 'myCurrentMod',myPlain); % ��ǰѡ��ĳ���
myScene.mySceneLib = {'ƽԭ','ɽ��','����','���','�ⲿ����'}; % ����ע��
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

end