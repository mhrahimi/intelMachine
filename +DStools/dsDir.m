function dirSet = dsDir(set)
setLen = length(set);

dirSet = cell(0);
for i = 1:setLen
    thisDirSet = dir(set{i});
    thisDirSet = thisDirSet(~cellfun('isempty', {thisDirSet.date})); 
    dirSet= [dirSet dirPlaner(thisDirSet)];
end

    function [fullDir, dirLen] = dirPlaner(dirStruct)
        fullDir = {};
        name = [{dirStruct.name}];
        folder = [{dirStruct.folder}];
        dirLen = length(folder);
        for j =  1:dirLen
            fullDir(j) = {fullfile(folder{j}, name{j})};
        end
    end
end