function tabularDS = tds(ds)

dsIndex = 1:ds.Len;
dsIndex = dsIndex(:);

file = ds.Files(:);
no = ds.No(:);
label = categorical(ds.Labels(:));
sensor = categorical(ds.Sensors(:));

lookupTable = table(file, no, label, sensor);
lookupTable = sortrows(lookupTable,'sensor','ascend');
lookupTable = sortrows(lookupTable,'label','ascend');
lookupTable = sortrows(lookupTable,'no','ascend');


tabularDS = lookupTable;

end