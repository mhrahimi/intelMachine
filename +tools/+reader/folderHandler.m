function [out, detail] = folderHandler(directory)
if nargin == 0
    directory = uigetdir;
end
% directory = "D:\0";
files = dir(directory);

for i = 1:numel(files)
    fileFullAdd = fullfile(files(i).folder, files(i).name);
    [out{i}, detail{i}] = tools.reader.fileHandler(fileFullAdd);
end
end