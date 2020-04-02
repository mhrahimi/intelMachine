function data = fetch(obj, index, subIndex)
% fetch  Read data from the permanent memory. -DataManipulation
%   data = fetch(index) Read the indexth data from the dataset from permanent
%   memory.
%
%   data = fetch(index, subIndex) (only for grinded datasets) Read the
%   subindex part of the indexth data from the dataset from permanent
%
%   See also SUMMON, FIND.

if nargin == 2
    if length(index) == 1
        data = readmatrix(obj.File{index}, 'NumHeaderLines', 0);
    else
        for dataIt = 1:length(data)
            data(dataIt) = {readmatrix(obj.File(index(dataIt)), 'NumHeaderLines', 0)};
        end
    end
elseif nargin == 3
    disp("Under construction!!");
end

if obj.filteringIsOn
    if nargin(obj.filteringFunction) == 2 % passes the properties to a function with two inputs
        data = obj.filteringFunction(data, propertiesFetch(index));
    else
        data = obj.filteringFunction(data);
    end
end

end