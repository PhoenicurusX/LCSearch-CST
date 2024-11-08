function [y_selected,x_selected] = SelectPointavg(maxlim,minlim,num,x,y)
A = maxlim; % 下限
B = minlim; % 上限

% 定义要选择的点数N
N = num;

% 找到y值在A-B之间的索引
indices = find(y <= A & y >= B);

% 提取满足条件的点
x_filtered = x(indices);
y_filtered = y(indices);

% 按y值从大到小排序
[~, sorted_indices] = sort(y_filtered, 'descend');
x_sorted = x_filtered(sorted_indices);
y_sorted = y_filtered(sorted_indices);

% 确保有足够的点，如果不够N个，则直接选出所有点
if length(x_sorted) < N
    N = length(x_sorted);
end


% 均匀选择N个点
% 通过线性间隔选择N个点：索引间隔为 length(y_sorted)/(N-1)
if N > 1
    idx = round(linspace(1, length(y_sorted), N));
else
    idx = 1; % 如果N=1，只选择最大点
end
if length(x_sorted)
x_selected = x_sorted(idx);
y_selected = y_sorted(idx);
else
    x_selected = [];
    y_selected = [];
end

end

