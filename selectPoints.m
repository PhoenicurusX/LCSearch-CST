function [selectedPoints, selectedIndices] = selectPoints(points, numPoints)
    % 确保点的数量至少为2
    if numPoints < 2
        error('至少需要选择2个点（包括最大值和最小值）。');
    end
    
    % 初始化输出数组
    selectedPoints = zeros(1, numPoints);
    selectedIndices = zeros(1, numPoints);
    
    % 找到最大值和最小值及其索引
    [minValue, minIndex] = min(points);
    [maxValue, maxIndex] = max(points);
    
    % 将最大值和最小值及其索引添加到结果中
    selectedPoints(1) = minValue;
    selectedPoints(end) = maxValue;
    selectedIndices(1) = minIndex;
    selectedIndices(end) = maxIndex;
    
    % 计算除了最大最小值外需要选取的点的数量
    numPointsToSelect = numPoints - 2;
    
    % 生成除最大最小值外的索引数组
    remainingIndices = setdiff(1:length(points), [minIndex, maxIndex]);
    
    % 从剩余的点中均匀选取点
    stepSize = floor(length(remainingIndices) / (numPointsToSelect + 1));
    selectedIntermediateIndices = remainingIndices(1:stepSize:end);
    selectedIntermediateIndices = selectedIntermediateIndices(1:numPointsToSelect);
    
    % 将选取的点及其索引添加到结果数组中
    selectedPoints(2:end-1) = points(selectedIntermediateIndices);
    selectedIndices(2:end-1) = selectedIntermediateIndices;
    
    % 排序，基于选取的点的值
%     [selectedPoints, sortIndex] = sort(selectedPoints);
%     selectedIndices = selectedIndices(sortIndex);
end