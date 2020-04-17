function data = transform(obj, transformationFunctoin, ind)

% #TODO replace out with a varargout
if nargin <= 2
    ind = 1:obj.Len;
end

for i = ind
    dataIn = obj.fetch(i);
    [height, width] = size(dataIn);
    for j = 1:width
        if nargin(transformationFunctoin) == 2 % passes the properties to a function with two inputs
            thisData = transformationFunctoin(dataIn(:,j), obj.propertiesFetch(i,"SubNo", j));
        else
            thisData = transformationFunctoin(dataIn(:,j));
        end
        if ~isempty(thisData)
            data(i,:,j) = thisData;
        end
    end
end
end