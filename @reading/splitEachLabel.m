function varargout = splitEachLabel(ds, sectionRatio)
% It is posbiliy that inctances from diffrent sources being
% splittd to sperated into diffrent datastores
% SHOULD NOT be used on multi sources datastore
randomizationIsOn = 0;

if 1 <= sum(sectionRatio)
    error("'sectionRatio' must be smaller than 1.");
end
%             sectionRatio(end+1) = 1 - sum(sectionRatio);

allSources = ds.Map.Mapping.Source.keys;
allLabels = ds.Map.Mapping.Label.keys;

for i = 1:length(sectionRatio)+1 % initialize the readings
    varargout{i} = reading.new(ds);
end

for i = 1:numel(allLabels)
    eachLabel = allLabels{i};
    thisLabelElements = ds.Map.all.(eachLabel)(:);
    [thisSize, ~] = size(thisLabelElements);
    indices = 1:thisSize;
    if randomizationIsOn
        indices = randperm(thisSize);
    end
    lastSectionEnd = 1;
    for j = 1:length(sectionRatio)
        thisSectionSize = floor(thisSize * sectionRatio(j));
        thisIndices = indices(lastSectionEnd:lastSectionEnd+thisSectionSize-1);
        varargout{j} = varargout{j} + cp(ds, indices(thisIndices));
        lastSectionEnd = lastSectionEnd+thisSectionSize;
    end
    j = j+1;
    thisIndices = indices(lastSectionEnd:end);
    varargout{j} = varargout{j} + cp(ds, indices(thisIndices));
end

end