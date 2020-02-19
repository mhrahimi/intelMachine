function destPath = moveon(inputPath)

[folderPath, folderName,~] = fileparts(inputPath);
destPath = fullfile(folderPath, [folderName, datestr(now,'_mmmm_dd_yyyy_HH_MM_SS_FFF_AM')]);
movefile(inputPath,destPath);
mkdir(inputPath);

destPath = string(destPath);

end
