function ds = dsGenFolder(folderPath, extention)

wildcardPath = fullfile(folderPath,'*',join(['*','.',extention],''));
dirs = dir(wildcardPath);
for i= 1:length(wildcardPath)
    [no(i), sensor(i), label(i), ~, ~, subNo(i)] = DStools.dsNameExtract({dirs(i).name});
    %      = {sensorTemp};
    %     label(i) = {labelTemp};
    exten(i) = {extention};
    files(i) = {fullfile(dirs(i).folder, dirs(i).name)};
end
ds.Files = files;
ds.No = no;
ds.Sensors = sensor;
ds.Labels = label;
ds.Extention = exten;
ds.Len = length(files);
ds.read = @(ind) readmatrix(ds.Files{ind});

ds.pull = @dsPull;

ds.subNo = subNo;


    function out = dsPull()
        if ds.Len < 1
            out = nan;
        else
            out = ds.read(ds.Len);  % output data
            ds.Len = ds.Len - 1
        end
    end


end