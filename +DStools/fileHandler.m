function data = fileHandler(varargin)
% fileHandler  add a .lvm file to the database "database.mat".
%   data = fileHandler() use UI get file to get the file and add to the database.
%
%   data = fileHandler(fileAdd) use UI get file to get the file and add to the database.
%
%   See also addToDatabase, folderHandler.

if length(varargin) ~= 0
    fileAdd = (varargin{1});
else
    [file,path] = uigetfile;
end

fileAdd = [path, file]


tool.brand = 'Seco';    tool.model = 'JS452120E3R050.0Z2-HEMI';   tool.numOfFlutes = 2;
cut.a.start = 0;    cut.a.end = 7;    cut.series ='';    cut.type ='slope';
material.typle = 'aluminum';    material.alloy = 7075;
comments = '';

addToDatabase(fileAdd, material, tool, cut, comments);

end