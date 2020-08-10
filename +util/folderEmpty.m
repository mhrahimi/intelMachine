function folderEmpty(path)
dirList = dir(path);
dirListFull = fullfile(path, {dirList.name});
for i = 3:numel(dirListFull)
    rmdir(dirListFull{i}, 's');
end
end