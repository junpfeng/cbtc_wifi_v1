function [myObject,myEventdata] = get_track(myObject, myEventdata)
% �����������㲢���ع���������Ե������AP����
% ����ʱ ������AP�����ֱ�߶Ρ����Ρ�����(�ܹ��м��ι��ƴ�ӵ�)��
% ��� �������Ե������AP������
           % ��㡢�յ� 
Step = myObject.myTrack.Step;
Interval = myObject.myTrack.Interval;
LineCell = myObject.myTrack.LineCell;
CircleCell = myObject.myTrack.CircleCell;
N = myObject.myTrack.TrackN;           
           
           
LineLen = length(LineCell);
        % �̶���ʽ����5��Ԫ��������һ����������������5�ı���
CircleLen = length(CircleCell);
X = {};
Y = {};
% Ԥ�����ڴ�
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
%Y = unique(cell2mat(Y)); % ΪʲôҪ�� unique
Y = cell2mat(Y);
apx = X(1:Interval/Step:length(X));
apy = Y(1:Interval/Step:length(Y)); 
%plot(X, Y, 'x');  % �������� 
%plot(apx, apy, 'O');  % AP����

track_x = X; track_y = Y;
ap_x = apx; ap_y = apy;
% ����Ϊֹ��X��Y�����δ���˹�����п��ܵı�������������֮꣬��ֻ��Ҫȡ������������������жϼ��ɡ�
myObject.myTrack.TrackX = track_x;
myObject.myTrack.TrackY = track_y;
myObject.myRtx.ApX = ap_x;
myObject.myRtx.ApY = ap_y;


end

