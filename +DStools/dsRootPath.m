function dsPath = dsRootPath
dsPath = mfilename('fullpath');
fileSepLoc = strfind(dsPath, filesep);
dsPath = dsPath(1:fileSepLoc(end-1));
dsPath = fullfile(dsPath, "DS");
end