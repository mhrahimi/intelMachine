function out = find(obj, no, source, label)
% find  Gets the source, lable, and number in order to read the
%
%   See also SUMMON, FIND.
validNos = zeros(1, obj.Len);
validSources = zeros(1, obj.Len);
validLabels = zeros(1, obj.Len);

if nargin <= 3 || util.isWildcard(label)
    validLabels = ones(1, obj.Len);
    if nargin <= 2 || util.isWildcard(source)
        validSources = ones(1, obj.Len);
        if nargin == 1 || util.isWildcard(no)
            validNos = ones(1, obj.Len);
        else
            for noIt = 1:length(no)
                validNos = validNos | (obj.No == no(noIt));
            end
        end
    else
        for sourceIt = 1:length(source)
            validSources = validSources | (obj.Source == source(sourceIt));
        end
    end
else
    for labelIt = 1:length(label)
        validLabels = validLabels | (obj.Label == label(labelIt));
    end
end

out = validNos & validSources & validLabels;
out = [1:obj.Len] .* out;
out = out(out ~= 0);
end