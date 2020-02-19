function appendTable(inTable, tableName)

if exist(tableName)
    [filePath, fileName,fileExt] = fileparts(tableName);
    tempTableName = fullfile(filePath, [fileName, '__1', fileExt]);
    writetable(inTable, tempTableName,'WriteVariableNames',false);
    system(['type ' tempTableName ' >> ' tableName]);
else
    writetable(inTable,tableName);
end
end