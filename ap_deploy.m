function [ap_cell] = ap_deploy(ap_x, ap_y, M)
% 输入为AP有可能存在的点(x轴的点和y轴的点)和需要部署AP的数量
% 输出为所有AP的实际部署情况的元组，是按照矩阵的形式输出的，例如5中选3的可能是10个，那么就是输出10*3个元组
% 每一行是一种情况，有三个元组，每个元组是该情况下的选的元素，因为是选3所以有3个。
ap_len = length(ap_x);
ap_cell = cell(1, ap_len);
for i = 1:ap_len
    ap_cell{i} = [ap_x(i), ap_y(i)];
end
ap_cell = nchoosek(ap_cell, M); % 排列组合函数，从ap_cell中选M的所有情况