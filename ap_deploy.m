function [ap_cell] = ap_deploy(ap_x, ap_y, M)
% ����ΪAP�п��ܴ��ڵĵ�(x��ĵ��y��ĵ�)����Ҫ����AP������
% ���Ϊ����AP��ʵ�ʲ��������Ԫ�飬�ǰ��վ������ʽ����ģ�����5��ѡ3�Ŀ�����10������ô�������10*3��Ԫ��
% ÿһ����һ�������������Ԫ�飬ÿ��Ԫ���Ǹ�����µ�ѡ��Ԫ�أ���Ϊ��ѡ3������3����
ap_len = length(ap_x);
ap_cell = cell(1, ap_len);
for i = 1:ap_len
    ap_cell{i} = [ap_x(i), ap_y(i)];
end
ap_cell = nchoosek(ap_cell, M); % ������Ϻ�������ap_cell��ѡM���������