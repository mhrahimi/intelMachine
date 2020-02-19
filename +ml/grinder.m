function out = grinder(input, batchSize, inFunc, doubleOut, matTableOutput)

len = length(input(:, 1, 1));
if nargin <= 4
    matTableOutput = 0;
end
if nargin <= 3
    doubleOut = 1;
end
if nargin <= 2 || ~isa(inFunc, 'function_handle')
    inFunc = @(x) x;
end

i = 1;
for j = batchSize:batchSize:len
    if matTableOutput == 0
        out(i) = {inFunc(input(j-batchSize+1:j,:,:))};
    elseif matTableOutput == 1 || matTableOutput == 2
        out(i, :) = inFunc(input(j-batchSize+1:j));
    end
    i= i+1;
end
if doubleOut && rem(len, batchSize) % do the backward grinding only if it doesn't match the forward one
    for j = len:-batchSize:batchSize
        if matTableOutput == 0
            out(i) = {inFunc(input(j-batchSize+1:j,:,:))};
        elseif matTableOutput == 1 || matTableOutput == 2
            out(i, :) = inFunc(input(j-batchSize+1:j));
        end
        i= i+1;
    end
end

if ~exist('out')
    out = inFunc(NaN);
end

% not sure why did i use it at the first place
if matTableOutput == 2 && ~istable(out) && ~isstruct(out)
    out = array2table(out);
end

if isstruct(out)
    out = struct2table(out);
end


end