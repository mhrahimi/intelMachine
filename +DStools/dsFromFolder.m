function dsOut = dsFromFolder(folderPath, sensors, sampling, diameter, numFlutes, feed, spindleSpeed, depthCut)
suffix = '.csv';
thePath = fullfile(folderPath,['*',suffix]);

% if nargin == 0 || isempty(folderPath) || isnan(folderPath)
%     folderPath = uigetdir;
% end

dsOut.Files = DStools.dsDir(thePath);
dsOut.Len = length(dsOut.Files);
dsOut.read = @(ind) readmatrix(dsOut.Files{ind});
dsOut.pull = @dsPull;

if 5 <= nargin
    for i = 1:dsOut.Len
        dsOut.No(i) = i;
        dsOut.Labels(i) = "Unknown";
        dsOut.Sensors(i) = sensors;
        dsOut.sampling(i) = sampling;
        dsOut.diameter(i) = diameter;
        dsOut.numFlutes(i) = numFlutes;
        dsOut.F = feed;
        dsOut.S = spindleSpeed;
        dsOut.a = depthCut;
    end
%     dsOut.sampling = @(n)
end

    function out = dsPull()
        if dsOut.Len < 1
            out = nan;
        else
            out = dsOut.read(dsOut.Len);  % output data
            dsOut.Len = dsOut.Len - 1
        end
    end

end