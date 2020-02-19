function ds2DataStore(ds, writeFunc, extention, rootPath)

if nargin <= 2
    rootPath = uigetdir;
end

labels = unique(ds.Labels);
sensors = unique(ds.Sensors);

for s = sensors
    for l = labels
        folderPath = fullfile(rootPath, s, l);
        mkdir(folderPath);
    end
end

for i = 1:ds.Len
    n = ds.No(i);
    l = ds.Labels(i);
    s = ds.Sensors(i);
    
    fileName = DStools.dsNameGen(n, s, l, extention);
    fullPath = fullfile(rootPath, s, l, fileName);
    writeFunc(ds.read(i), fullPath);
end

end