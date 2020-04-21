function [fileDir, fileName, fileDirName] = runningFileDir(inputName)
fileName = mfilename;
fileDirName = mfilename('fullpath');
endDir = strfind(fileDirName, fileName)-2;
fileDir = fileDirName(1:endDir);
if 1 <= nargin
    fileDir = fullfile(fileDir, inputname);
end
end