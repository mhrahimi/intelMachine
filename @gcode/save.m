function save(obj, fileName)
UIFile = true;
if nargin <= 1
    if ~UIFile
        if ~isempty(obj.programName)
            fileName = [obj.programName, '.txt'];
        else
            fileName = ['UNNAMMED', datetime];
        end
    else
        filter = {'*.h';'*.txt';'*.*'};
        [file, path] = uiputfile(filter);
        fileName = fullfile(path, file);
    end
end
code = obj.disp;
fid=fopen(fileName,'w');
fprintf(fid, code);
end