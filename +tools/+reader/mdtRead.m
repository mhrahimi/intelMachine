function [data, detail] = mdtRead(fileAdd)
data = readtable(fileAdd, ...
    'ReadVariableNames', false, 'FileType', 'delimitedtext');
% post processing
% data(:, end) = [];
data.Properties.VariableNames{1} = 'Time';
end