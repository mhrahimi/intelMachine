function [ds] = dsGen(no, sensor, label)

if isequal(no, "all") || all(no == -1)
    no = '*';
end

if nargin <2 || isequal(sensor, "all") || (isnumeric(sensor) && all(sensor == -1))
    sensor = '*';
end

if nargin<3 || isequal(label, "all") || (isnumeric(label) && all(label == -1))
    label = '*';
end

% char to string:
if nargin > 1 && isa(sensor, 'char')
    sensor = convertCharsToStrings(sensor);
end
if nargin > 2 && isa(label, 'char')
    label = convertCharsToStrings(label);
end

if nargin <= 3
%     dsPath = mfilename('fullpath');
%     fileSepLoc = strfind(dsPath, filesep);
%     dsPath = dsPath(1:fileSepLoc(end-1));
%     dsPath = fullfile(dsPath, "DS");
    dsPath = DStools.dsRootPath;
end

extention = ".csv";
i = 1;

for n = no
    for s = sensor
        for l = label
            dsName = DStools.dsNameGen(n, s, l, extention);
            location = fullfile(dsPath, dsName);
            set(i) = location;
            i = i + 1;
        end
    end
end

ds.Files = DStools.dsDir(set);
[ds.No, ds.Sensors, ds.Labels, ds.Extention] = DStools.dsNameExtract(ds.Files);
ds.Len = length(ds.Files);
ds.read = @(ind) readmatrix(ds.Files{ind});
ds.pull = @dsPull;


    function out = dsPull()
        if ds.Len < 1
            out = nan;
        else
%             out = ds.Files(ds.Len);   % output file path
            out = ds.read(ds.Len);  % output data
            ds.Len = ds.Len - 1
        end
    end

end














































