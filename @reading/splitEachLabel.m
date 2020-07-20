function [varargout] = splitEachLabel(ds, varargin)
% It is posbiliy that inctances from diffrent sources being
% splittd to sperated into diffrent datastores
% SHOULD NOT be used on multi sources datastore
randomizationIsOn = 0;

for i = 1:length(varargin)
    eachRatio = varargin{i};
    sectionRatio(i) = eachRatio;
end

if 1 <= sum(sectionRatio)
    error("'sectionRatio' must be smaller than 1.");
end
sectionsIndices = cell(numel(sectionRatio)+1, 1);

allLabels = ds.Map.Mapping.Label.keys;

for i = 1:numel(allLabels)
    eachLabel = allLabels{i};
    thisLabelElements = ds.Map.all.(eachLabel)(:);
    [thisSize, ~] = size(thisLabelElements);
    indices = 1:thisSize;
    if randomizationIsOn
        indices = randperm(thisSize);
    end
    lastSectionEnd = 1;
    for j = 1:numel(sectionRatio)
        thisSectionSize = floor(thisSize * sectionRatio(j));
        thisIndices = indices(lastSectionEnd:lastSectionEnd+thisSectionSize-1);
        sectionsIndices{j} = [sectionsIndices{j};...
            thisLabelElements(thisIndices)];
%         varargout{j} = varargout{j} + cp(ds, indices(thisIndices));
        lastSectionEnd = lastSectionEnd+thisSectionSize;
    end
    j = j+1;
    thisIndices = indices(lastSectionEnd:end);
    sectionsIndices{j} = [sectionsIndices{j};...
            thisLabelElements(thisIndices)];
end

for i = 1:numel(sectionsIndices)
    varargout{i} = copy(ds);
    indicesComplement = [1:ds.Len];
    indicesComplement(sectionsIndices{i}) = [];
    varargout{i} = delete(varargout{i}, indicesComplement);
end
varargout{end+1} = sectionsIndices;
end