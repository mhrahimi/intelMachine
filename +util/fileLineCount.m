function numLines = fileLineCount(fileAdd)
% fileLineCount counts the number of lines in a file

% tic
% if ispc
%     command = join(['type "' fileAdd '" | find /c /v ""'],'');
% else
%     error("Just add the Linux command");
% end
% [status,numLines] = system(command);
% numLines = str2num(numLines);
% numLines
% toc
% % dirOut = dir(fileAdd);
% % numLines = dirOut.bytes/10;
% tic
% toc
% tic
% aa = readmatrix(fileAdd);
% length(aa)
% toc


[filepath,fileName,ext] = fileparts(fileAdd); % find the DS/DB path
dbPath = fullfile(filepath, 'lineCountDB.dat');
theDBexists = exist(dbPath);

if theDBexists
    lineCountDB = readcell(dbPath);
    
    lineCountDBInd = find(ismember(lineCountDB(:,1),fileName));
    if length(lineCountDBInd) % founded in the db
        numLines = lineCountDB{lineCountDBInd,2};
    else
        numLines = fLineCount(fileAdd);
        
        lineCountDB(end+1,1) = {fileName};
        lineCountDB(end,2) = {numLines};
        
        lineCountDB = sortrows(lineCountDB);
        writecell(lineCountDB, dbPath, 'QuoteStrings', true);
    end
else
    numLines = fLineCount(fileAdd);
    
    lineCountDB(1,1) = {fileName};
    lineCountDB(1,2) = {numLines};
    
    writecell(lineCountDB, dbPath, 'QuoteStrings', true);
end

end

function numLines = fLineCount(fileAdd)

fid = fopen(fileAdd);
numLines = 0;
while ischar(fgetl(fid))
    numLines = numLines+1;
end
fclose(fid);

end