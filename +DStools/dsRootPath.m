function dsPath = dsRootPath(inputPath)
persistent persistentPath
if nargin == 0 % Just reading dsPath
    if isempty(persistentPath)
        warning(['The dsPath is empty. First, you have to assign a value to dsPath using "dsRootPath(inputPath)"']);
    end
    dsPath = persistentPath;
elseif 1 <= nargin % assign and read
    if ~isempty(persistentPath)
        warning(['The current value of dsPath "', persistentPath, '" has been overwritten.']);
    end
    if ~isfolder(inputPath)
        warning(['"', inputPath, '" is NOT A VALID FOLDER.']);
    end
    persistentPath = inputPath;
    if nargout == 1 % if we need to have an output
        dsPath = inputPath;
    end
end

end