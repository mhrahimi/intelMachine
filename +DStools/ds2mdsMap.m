function mapOut = ds2mdsMap(ds,mds, replacmentSensor)

files = mds.Files;
numFiles = length(files);
mapOut = zeros(numFiles,2);
dsStruct = DStools.ds2structMap(ds);
for i = 1:numFiles
    [thisNo, thisSensor, thisLabel, ~, ~, thisSubNo] = DStools.dsNameExtract(files(i));
    if 3 <= nargin
        thisSensor = replacmentSensor;
    end
    mapOut(i,1) = dsStruct(thisNo).(thisSensor{1}).(thisLabel{1});
    mapOut(i,2) = str2num(thisSubNo{1});
end

end