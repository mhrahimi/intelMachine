function path = desktopDir(folderName)
cUser= 'C:\Users';
userName= getenv('username');
% folderName=get(handles.edit1,'String');
if nargin <=0
    folderName = '';
end
folderName= char(folderName);
path = fullfile(cUser,userName,'Desktop', folderName);
end