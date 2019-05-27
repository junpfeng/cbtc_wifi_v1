function [myObject,myEventdata] = bf_search(myObject, myEventdata)
% ֻҪ��������������иı䣬��ô�������ô��ݣ�������Ϊ�����ϴ��Ӱ��Ч��
% ������ AP������AP�ĺ����꼯�ϣ������꼯�ϣ����书�ʺ�����
% ����� Cn,m0��m1��m2�ֱ���Ŀ��AP��������վ�ĸ����źŵľ�ֵ����
% ��������п��ܵ�AP�������ѡ�񼸸���������AP
for i_ = myObject.myRtx.ApRange(1):myObject.myRtx.ApRange(2);
myEventdata.ApM = i_;  % ��ǰ���в��õ�AP������ 
M = i_;
alpha = myObject.myCost.alpha; % �������� 
beta = myObject.myCost.alpha;  % �������� 

ApCell = ap_deploy(myObject.myRtx.ApX, myObject.myRtx.ApY, myEventdata.ApM); % AP��������п���
myEventdata.ApCell = ApCell;    % ����ṹ��
ApNum = length(ApCell); % һ��AP_num�ַ���
TrackPointNum = myObject.myTrack.TrackPoint; % ������Ե�����
Interf1 = myObject.myInterf.Interf1;
Interf2 = myObject.myInterf.Interf2;
TrackX = myObject.myTrack.TrackX;
TrackY = myObject.myTrack.TrackY;

% Ԥ�����ڴ�
m0 = zeros(ApNum, TrackPointNum); m1 = zeros(ApNum, TrackPointNum); m2 = zeros(ApNum, TrackPointNum); % ��ž�ֵ
pOut2 = zeros(ApNum, TrackPointNum); % ����жϸ���
ApDis = zeros(1,M);    % ����AP��������Ե�ľ��룬֮��תΪĿ��AP�����Ե�ľ���

for type = 1:ApNum % ����ÿһ��AP���𷽰�
%% ����
    for i = 1:TrackPointNum % �����������i�����ع���ľ���
        % �ɾ��뷴�ⲽ������
        %  ���㲽�������֮��ľ���
        Interf1Dis = distance(Interf1 ,[TrackX(i), TrackY(i)]); %��һ��������𳵵ľ���
        Interf2Dis = distance(Interf2 ,[TrackX(i), TrackY(i)]); %�ڶ���������𳵵ľ���
        % ʹ�ñȽϷ��ж��ĸ���Ŀ��AP
        for j = 1:M % ����ÿһ��AP���𷽰���ÿһ�����Ե㣬��ÿ��AP���,M��ʾһֱ���𷽰��µ�AP���� 
            ApDis(j) = distance([TrackX(i), TrackY(i)], [cell2mat(ApCell(type, j))]);
        end
        ApDis = min(ApDis); % ������С����ΪĿ��AP���г��ľ���
        % �����жϸ���
        myEventdata.Distance.ApDis = ApDis;
        myEventdata.Distance.Interf1Dis = Interf1Dis;
        myEventdata.Distance.Interf2Dis = Interf2Dis;
        
        % ������ܸ��Ź��ʵ�����i
        myObject.myScene.myCurrentMod.Index = i;
        
        [pOut2(type, i), m0(type, i), m1(type, i), m2(type, i)] = outage2_p(myObject, myEventdata);
        
        
%         ii = ii + 1;
    end
end
myEventdata.pOut2 = pOut2; % ����ṹ��
myEventdata.OptMeanPower.M0 = m0; % ����ṹ��
myEventdata.OptMeanPower.M1 = m1; % ����ṹ��
myEventdata.OptMeanPower.M2 = m2; % ����ṹ��

    % ������ۣ�������Ž�
    [myObject,myEventdata] = cost(myObject,myEventdata);
    
    % �����cost�ҵ������Ų�����˳����������������������
    if myEventdata.IsOpt == 1
        myEventdata.IsOpt = 0;
        break;
    end
%     m00 = m0(locat,:);
%     m11 = m1(locat,:);
%     m22 = m2(locat,:);
end
