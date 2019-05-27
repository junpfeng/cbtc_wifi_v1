function [M0, M1, M2] = OtherPLSF(myObject,myEventdata)
% ˵�����ŵ�ģ�ͺ���
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
% ���ؽ��յ���Ŀ��AP������1������2�ľ�ֵ
%   �˴���ʾ��ϸ˵��
fc = 2.4e6;
% R = myObject.myRtx.MatRx{3};    % ���ջ���СҪ����Ÿɱ�
pt0 = myObject.myRtx.MatTx(1); gt0 = myObject.myRtx.MatTx(2); % Ŀ��AP�ķ��书��
pt1 = myObject.myInterf.MatTx(1);  % ���Ż�վ�ķ��书��
pt2 = myObject.myInterf.MatTx(2); 
gt1 = 0; gt2 = 0;   % �ѷ�������ŵ����书����
gr = myObject.myRtx.MatRx(1);   % ��������

n = myObject.myScene.myCurrentMod.Exp; % �ŵ�ģ�͵�ָ��
d0 = myObject.myScene.myCurrentMod.Refer; % �ŵ�ģ�Ͳο�����

%% ----------����Ŀ��AP�ľ�ֵ
ApDis = myEventdata.Distance.ApDis; % ��ʱ���Ե���Ŀ��AP�ľ���
if ApDis < 1, ApDis = 1; end
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%·���������
    M0 = pt0+gt0+gr-10*n*log10(abs(ApDis)/d0)+10*log10(k);  %�ɹ�ʽ�ɵ�
    %   q = q;��׼���

%% ----------���Ը���1�ľ�ֵ
Interf1Dis = myEventdata.Distance.Interf1Dis;   % ����Ż�վ1�ľ���
if Interf1Dis < 1, Interf1Dis = 1; end
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%·���������
    M1 = pt1+gt1+gr-10*n*log10(abs(Interf1Dis)/d0)+10*log10(k);  %�ɹ�ʽ�ɵ�
    %   q = q;��׼���
    
%% --------���Ը���2�ľ�ֵ
Interf2Dis = myEventdata.Distance.Interf2Dis;
if Interf2Dis < 1, Interf2Dis = 1; end
    lamda = 3e8/fc;
    k = (lamda/(4*pi*d0)).^n  ;%·���������
    M2 = pt2+gt2+gr-10*n*log10(abs(Interf2Dis)/d0)+10*log10(k);  %�ɹ�ʽ�ɵ�
    %   q = q;��׼���
    
end
    

    

