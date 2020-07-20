function [data, detail] = scoRead(fileAdd)
eohTXT = "%[DATA]";
lineCounter = 1;
nameCounter = 1;

fid = fopen(fileAdd, 'r');
% header 1
rLine = fgetl(fid);
lineCounter = lineCounter + 1;
while ~contains(rLine, eohTXT)
    rLine = fgetl(fid);
    lineCounter = lineCounter + 1;
    
    if contains(rLine, '%NAME=')
        detail.name{nameCounter} = rLine(7:end);
        nameCounter = nameCounter + 1;
    end
end
fclose(fid);

data = readtable(fileAdd, ...
    'HeaderLines', lineCounter-1, 'ReadVariableNames', false, 'FileType', 'delimitedtext');
% post processing
data(:, end) = [];
data.Properties.VariableNames{1} = 'Time';
for i = 2:numel(data.Properties.VariableNames)
data.Properties.VariableNames{i} = detail.name{i-1};
end
end