function glimps(varargin)
% glimps  read a lvm file and plot all of its entries and their FFTs, using mPlotter.
%   glimps() Open-up the uigetfile dialog looking for the file to read.
%
%   glimps(fileAddress) read the existing file at the fileAddress (the
%   input).
%
%   See also dbRead, mPlotter, lvmRead.


close all

if length(varargin) ~= 0
    fileAdd = (varargin{1});
else
    [file,path] = uigetfile;
end

fileAdd = [path, file]

[rawData, details] = intelMachine.DBtools.lvmRead(fileAdd);
% data = dataDriver(rawData);
% data.Properties.Description = [details.date, ' ', details.time];
intelMachine.DBtools.mPlotter(rawData)
% mPlotter(data)
% summary(data)

end