function [no, sensor, label, extention, t, subNo] = dsNameExtract(name)

for i = 1:length(name)
    editedName = name{i};
    if strfind(editedName, filesep) % convert file path to file name
        fileSepLoc = strfind(editedName, filesep);
        fileSepLoc = fileSepLoc(end);
        editedName = convertStringsToChars(editedName);
        editedName = editedName(fileSepLoc+1:end);
    end
    
    no(i) = str2double(betweenUnderlines(editedName, 'N'));
    sensor(i) = {betweenUnderlines(editedName, 'S')};
    label(i) = {betweenUnderlines(editedName, 'L')};
    extention(i) = {extentionFinder(editedName)};
    if 6 <= nargout
        subNo(i) = {betweenUnderlines(editedName, 'g')};
    end
    
    i = i+1;
end

if 5 <= nargout
    t = table(no', sensor', label', extention');
    t.Properties.VariableNames = [{'No'}, {'Sensor'}, {'Label'}, {'Extention'}];
end

    function out = betweenUnderlines(str, identifier)
        nS = strfind(str, [identifier, '_']) + 2;
        nE = strfind(str(nS:end), '_');
        if isempty(nE) || isempty(nS)
            out = nan;
            return
        end
        nE = nE(1) + nS - 2;
        out = str(nS:nE);
    end
    function out = extentionFinder(str)
        nS = strfind(str, '.') + 1;
        nE = length(str);
        if isempty(nS)
            out = nan;
            return
        end
        out = str(nS:nE);
    end
end