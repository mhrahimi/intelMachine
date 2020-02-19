function fOut = dsTransform(ds, fIn)

ds.read = @(ind) fIn(ds.read(ind));
fOut = ds;

end