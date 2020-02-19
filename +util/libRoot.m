function root = libRoot
    root = mfilename('fullpath');
    fileSepLoc = strfind(root, filesep);
    root = root(1:fileSepLoc(end-1));
end