function [data, nonGrindedData] = fetch(obj, index, subIndex)
% fetch  Read data from the permanent memory. -DataManipulation
%   data = fetch(index) Read the indexth data from the dataset from permanent
%   memory.
%
%   data = fetch(index, subIndex) (only for grinded datasets) Read the
%   subindex part of the indexth data from the dataset from permanent
%
%   See also SUMMON, FIND.

if nargin == 2
    rawData = obj.readingFunction(obj.File{index}); % reading one instance
    nonGrindedData = rawData;
    if obj.isGrinded
        rawData = slicer(obj, nonGrindedData, obj.BatchInd{index});
    end
elseif nargin == 3 % subIndex
    subIndicies = obj.BatchInd{index};
    sLine = subIndicies(subIndex,1);
    eLine = subIndicies(subIndex,2);
    rawData = util.freadLine2Line(obj.File{index},sLine,eLine);
end
% if 2 <= nargout

% end

[~, width] = size(rawData);
if ~obj.FilteringIsOn & ~obj.TransformationIsOn
    data = rawData;
else
    data = cell(width, 1);
end
if obj.FilteringIsOn
    for i = 1:width
        if nargin(obj.FilteringFunction) == 2 % passes the properties to a function with two inputs
            data(:,i) = {obj.FilteringFunction(rawData(:,i), obj.propertiesFetch(index,'Part', i))};
        else
            data(:,i) = {obj.FilteringFunction(rawData(:,i))};
        end
    end
end
if obj.TransformationIsOn
    for i = 1:width
        if nargin(obj.TransformationFunction) == 2 % passes the properties to a function with two inputs
            data(:,i) = {obj.TransformationFunction(rawData(:,i), obj.propertiesFetch(index,'Part', i))};
        else
            data(:,i) = {obj.TransformationFunction(rawData(:,i))};
        end
    end
end


end