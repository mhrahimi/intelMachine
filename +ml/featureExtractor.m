function tOut = featureExtractor(ds, Fcns)
tOut = table();
if isfield(ds,'gread') %check if it's a grinded ds
    for n = 1:ds.Len
        if ds.gNum(n)
            
            for g = 1:ds.gNum(n)
                thisRow = [];
                if length(Fcns)
                    for fC = 1:length(Fcns)
                        if iscell(Fcns)
                            thisFcn = Fcns{fC};
                        else
                            thisFcn = Fcns;
                        end
                        thisInstance = thisFcn(ds.gread(n,g));
                        if isstruct(thisInstance)
                            thisInstance = struct2table(thisInstance);
                        elseif ismatrix(thisInstance)
                            thisInstance = array2table(thisInstance);
                            numCopies = length(thisInstance.Properties.VariableNames);
                            thisInstance.Properties.VariableNames = nameCopier(func2str(thisFcn), numCopies);
                        end
                        if istable(thisInstance)
                            thisRow = [thisRow, thisInstance];
                        end
                    end
                    this.no = n;
                    this.fileNo = ds.No(n);
                    this.gNo = g;
                    this.label = categorical(ds.Labels(n));
                    thisRow = [thisRow, struct2table(this)];
                end
                tOut = [tOut; thisRow];
                if isnan(tOut.kurtosis(end))
                    disp(1);
                end
            end
        end
    end
else % not grinded ds
    disp('assdsf')
end
end
function cellOut = nameCopier(strIn, numCopies)

cellOut = cell(numCopies, 1);
for i = 1:numCopies
    if i==1 % first one won't get numbered
        cellOut(i) = {[strIn]};
    else
        cellOut(i) = {[strIn, '_', str2num(i-1)]};
    end
end

end