function [out,label, sensor] = dsGrinder(ds, batchSize, inFunc)
f = waitbar(0,['dsGrinder initializing'] );
if nargin <= 2
    inFunc = NaN;
end


out = table();
label = [];
sensor = [];
for i = 1:ds.Len
    input = ds.read(i);
    thisDS = ml.grinder(input, batchSize, inFunc, 2);
    out = [out; thisDS];
    
    if nargout > 1
        label = [label, repelem(categorical(ds.Labels(i)), height(thisDS))];
        sensor = [sensor, repelem(categorical(ds.Sensors(i)), height(thisDS))];
    end
    
    waitbar(i/ds.Len, f, ['Grinding DSs - DS #', num2str(i), ' out of ', num2str(ds.Len)] );
end
if 2 <= nargout
    label = array2table(label(:));
    label.Properties.VariableNames = {'label'};
    sensor = array2table(sensor(:));
    sensor.Properties.VariableNames = {'sensor'};
end

close(f)

end