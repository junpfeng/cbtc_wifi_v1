function [myObject, myEventdata] = outage_vaildate(myObject, myEventdata)
%UNTITLED input Ŀ���źž�ֵ���С����������źž�ֵ���С��жϸ��ʵ���ֵ
% �Ÿɱ� = �����źŹ���/�����źţ����ǰ��������ţ������ض��ĸ����źţ�����
% �Ÿɱ� = Ŀ���źž�ֵ/�����źž�ֵ
%   output : ��֤���жϸ���
%   �˴���ʾ��ϸ˵��

% �Ÿɱ�
Sir = myEventdata.OptMeanPower.M0 - (myEventdata.OptMeanPower.M1 - myEventdata.OptMeanPower.M2 + myObject.myInterf.NoisePower);
Outage = 0; % ʹ����һ�ְ취ͳ���жϸ���
for i = 1:myObject.myTrack.TrackPoint
    if Sir(i) < myObject.myRtx.Threshold
        Outage = Outage + 1;
    end
%% ��֤�Ƿ����    
if myEventdata.MaxOut(myEventdata.OptPosition) < myObject.myRtx.Threshold 
    if (Outage/myObject.myTrack.TrackPoint) < myObject.myRtx.Threshold
        myEventdata.IsOpt = 1;
    else
        myEventdata.IsOpt = 1;
    end
end



end

