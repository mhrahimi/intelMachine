function [data, detail] = fileHandler(fileFullAdd)
if nargin == 0
    fileFullAdd = uigetfile('*.*');
end
fileSplitted = strsplit(fileFullAdd, '.');
extention = fileSplitted{end};
switch lower(extention)
    case "lvm"
        data = tools.reader.lvmRead(fileFullAdd);
        detail.formate = "lvm";
    case "sco"
        data = tools.reader.scoRead(fileFullAdd);
        detail.formate = "sco";
    case "mdf"
        data = tools.reader.mdtRead(fileFullAdd);
        detail.formate = "mdf";
    otherwise
        data = table();
        detail = [];
end
end