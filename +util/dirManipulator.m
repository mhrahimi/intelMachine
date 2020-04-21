function output = dirManipulator(inputDir, varargin)
parts = strsplit(inputDir, filesep);
inputIt = length(parts);
for i = 1:length(varargin)
    thisInput = varargin{i};
    if isequal(thisInput, '..')
        inputIt = inputIt - 1;
        parts = parts(1:inputIt);
    else
        inputIt = inputIt + 1;
        parts{inputIt} = char(varargin{i});
    end
end
output  = parts{1};
for i = 2:length(parts)
    output = [output, filesep, parts{i}];
end
end