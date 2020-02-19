function folderHandler(varargin)
% folderHandler  add a all of the .lvm files in a folder to the database "database.mat".
%   data = folderHandler() use UI get folder to get the file and add all of the files to the database.
%
%   data = fileHandler(folderAdd) use UI get folder to get the folder and add its files to the database.
%
%   See also addToDatabase, fileHandler.

if length(varargin) ~= 0
    fileAdd = (varargin{1});
else
    folderAdd = uigetdir;
end



f = waitbar(0,'Please wait...');

filesList = dir(folderAdd);
folder = filesList(1).folder;
numOfFiles = length(filesList);

tool.brand = 'Seco';    tool.model = 'JS452120E3R050.0Z2-HEMI';    tool.numOfFlutes = 2;    tool.diameter = 12;
cut.a.start = 0;    cut.a.end = 6;    cut.series ='S2_1';    cut.type ='slope';     cut.S = 12335;
material.typle = 'aluminum';    material.alloy = 7075;
comments = 'depth of cut is NOT quite accurate';

for i=3:numOfFiles
    waitbar((i-3)/(numOfFiles-2),f,['Reading "', filesList(i).name, '"...']);
    addToDatabase([folder, filesep, filesList(i).name], material, tool, cut, comments);
end

close(f)

end


