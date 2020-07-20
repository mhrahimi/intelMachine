function components = gDecoder(obj, lineCode)
splitted = strsplit(lineCode);
splitted = splitted(~cellfun('isempty',splitted)); % delete empty cells
identifier = ['X','Y','Z','A','B','F','S','M'];
% identifier = obj.log.Properties.VariableNames;
% identifier = cell2mat(identifier(1:end-1));
identifierCorr = ['X','Y','Z','A','B','F','S',"M"];
components = array2table(zeros(0,8));
components.Properties.VariableNames = identifierCorr;
for i = 1:numel(splitted)
    idIndex = strfind(identifier, splitted{i}(1));
    if idIndex
        components.(identifierCorr(idIndex))(1) =...
            convertCharsToStrings(splitted{i}(2:end))
    end
end
end