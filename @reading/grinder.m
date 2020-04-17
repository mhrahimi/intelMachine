function grinder(obj, batchSize, doubleOut, ind)
% grinder  Breaks the dataset elements to smaller batches.
%   grinder(batchSize) Breaks the dataset elements to batches of size
%   batchSize. batchSize could be a single number, an array of number with
%   a length equal to the number of elements of dataset that you want to
%   grind, or a function with properties as its input.
%
%   grinder(obj, batchSize, doubleOut, ind) Breaks the dataset elements to
%   batches of size of batchSize. doubleOut is by deafualt 1, which means
%   it will grind the dataset forward and backward. ind is the indexes that
%   you want to grind. Without having ind as an input, function will grind
%   the whole dataset.
%
%   See also propertiesFetch.

waitbarIsOn = 0;
if nargin <=3
    if nargin <= 2
        doubleOut = 1;
    end
    ind = 1:obj.Len;
end
% batchSize handling
if length(batchSize) == 1
    batchSizeProcessed(ind) = batchSize;
end
if isa(batchSize, 'function_handle')
    for i = ind
%         batchSizeProcessed(i) = batchSize(obj.Properties);
        batchSizeProcessed(i) = batchSize(propertiesFetch(i));
    end
end

if waitbarIsOn, wBar = waitbar(0,'Grinding-up..');, end
for i = ind
    thisFileLineCount = util.fileLineCount(obj.File{i}); % TODO speedup by adding cache option
    parts = internalGrinderFunction(thisFileLineCount, batchSizeProcessed(i), doubleOut);
    obj.BatchInd(i) = {parts};
    obj.BatchCount(i) = length(parts);
    if waitbarIsOn, waitbar(i/obj.Len, wBar);, end
end
obj.isGrinded = 1;

if waitbarIsOn, close(wBar);, end

    function parts = internalGrinderFunction(len, batchSize, doubleOut)
        
        parts(:,2) = batchSize:batchSize:len;
        parts(:,1) = parts(:,2)-batchSize+1;
        
        
        if doubleOut && rem(len, batchSize) % do the backward grinding only if it doesn't match the forward one
            partSecondPortion(:,2) = len:-batchSize:batchSize;
            partSecondPortion(:,1) = partSecondPortion(:,2)-batchSize+1;
            
            parts = [parts; partSecondPortion];
        end
        
        if ~exist('parts')
            parts = NaN;
        end
    end
end