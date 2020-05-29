function dsout = plus(ds1, ds2)
dsout = reading.new;
dsout.File = [ds1.File, ds2.File];
dsout.No = [ds1.No, ds2.No];
dsout.Label = [ds1.Label, ds2.Label];
dsout.Source = [ds1.Source, ds2.Source];
dsout.Extention = [ds1.Extention, ds2.Extention];
dsout.Len = ds1.Len + ds2.Len;

dsout.Labels = [ds1.Labels; ds2.Labels];

dsout.Properties = [ds1.Properties; ds2.Properties];

if isMatching(ds1.FilteringIsOn, ds2.FilteringIsOn, 'FILTERING')
    dsout.FilteringIsOn = ds1.FilteringIsOn;
end
if isMatching(ds1.TransformationIsOn, ds2.TransformationIsOn, 'TransformationIsOn')
    dsout.TransformationIsOn = ds1.TransformationIsOn;
end

dsout.BatchInd = [ds1.BatchInd, ds2.BatchInd];
dsout.BatchCount = [ds1.BatchCount, ds2.BatchCount];

if isMatching(ds1.isGrinded, ds2.isGrinded, 'isGrinded')
    dsout.isGrinded = ds1.isGrinded;
end
if isequal(ds1.readingFunction, ds2.readingFunction)
    dsout.readingFunction = ds1.readingFunction;
end
    function out = isMatching(a, b, errorMessage)
        if ~xor(a,b)
            out = true;
        else
            error(['Addition is not possible - readings ', errorMessage,...
                ' propetry is inconsistant']);
            out = false;
        end
    end
end