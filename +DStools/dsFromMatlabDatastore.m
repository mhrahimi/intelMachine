function ds = dsFromMatlabDatastore(datastore, dsRoot, dsExtention)
% It works, yet, 100% usless! Feel free to delete it.
Files = datastore.Files;
for i = 1:length(Files)
    [fp, fn, fe] = fileparts(Files{i});
    fPath(i) = {fp};
    fName(i) = {fn};
    fExt(i) = {fe};
end

if 2 <= nargin
    for i = 1:length(fPath)
        dsPath(i) = {dsRoot};
    end
else
    dsPath = fPath;
end

if 3 <= nargin
    for i = 1:length(fExt)
        dsExt(i) = {dsExtention};
    end
else
    dsExt = fExt;
end

for i = 1:length(Files)
    ds.Files(i) = {fullfile(dsPath{i}, [fName{i}, dsExt{i}])};
end

[ds.No, ds.Sensors, ds.Labels, ds.Extention, ~, ds.g] = DStools.dsNameExtract(ds.Files);
ds.Len = length(ds.Files);
ds.read = @(ind) readmatrix(ds.Files{ind});
ds.pull = @dsPull;
ds.gread = @(no,piece) gread(no,piece);

    function dataOut = gread(no, piece)
        if ds.Len < no || ds.gNum(no) < piece
            dataOut = NaN;
            return
        end
        sl = ds.Parts(no);
        sl = sl{1};
        sl = sl(piece,1);
        
        el = ds.Parts(no);
        el = el{1};
        el = el(piece,2);
        dataOut = util.freadLine2Line(ds.Files{no},sl,el);
    end

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