function slicedData = slicer(obj, data, BatchInd)
if isempty(BatchInd)
    slicedData = [];
end
for i = 1:length(BatchInd)
    slicedData(:,i) = data(BatchInd(i,1): BatchInd(i,2));
end
end