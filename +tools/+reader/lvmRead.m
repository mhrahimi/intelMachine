function [data, detail] = lvmRead(fileAdd, options)
eohTXT = "***End_of_Header***";
lineCounter = 1;

fid = fopen(fileAdd, 'r');
% header 1
rLine = fgetl(fid);
lineCounter = lineCounter + 1;
while ~contains(rLine, eohTXT)
    rLine = fgetl(fid);
    lineCounter = lineCounter + 1;
end
% header 2
rLine = fgetl(fid);
lineCounter = lineCounter + 1;
while ~contains(rLine, eohTXT)
    rLine = fgetl(fid);
    lineCounter = lineCounter + 1;
end
fclose(fid);

data = readtable(fileAdd, ...
    'HeaderLines', lineCounter-1, 'ReadVariableNames', true, 'FileType', 'delimitedtext');
% post processing
data(:, end) = [];
data.Properties.VariableNames{1} = 'Time';

detail.formate = 'lvm';
% plotting 
if 2 <= nargin && isfield(options) && options.plotting
    
end
end