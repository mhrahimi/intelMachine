function [lt, nMap, sMap, lMap, ls]  =dsLookupTable(No, Source, Label)
index = [1:length(No)];

sortedTable  =table(index', No', Source', Label');
sortedTable.Properties.VariableNames = [{'Index'}, {'No'}, {'Source'}, {'Label'}];

sortedTable = sortrows(sortedTable, 'Label');
lMap = util.numberMapper(sortedTable.Label);

sortedTable = sortrows(sortedTable, 'Source');
sMap = util.numberMapper(sortedTable.Source);

sortedTable = sortrows(sortedTable, 'No');
nMap = util.numberMapper(sortedTable.No);


lt = NaN(sMap.Count, lMap.Count, nMap.Count);

for i = 1:length(No)
    lt(sMap(sortedTable.Source{i}), lMap(sortedTable.Label{i}), nMap(sortedTable.No(i))) = sortedTable.Index(i);
    if 5 <= nargout
        ls.(sortedTable.Source{i}).(sortedTable.Label{i})(nMap(sortedTable.No(i))) = sortedTable.Index(i);
    end
end



%
% lUnique = unique(Label);
% sUnique = unique(Source);
% len = length(No);
% ls = struct();
%
% %% empty table generation
% for l = lUnique
%     for s = sUnique
%         lt.(l{1}).(s{1}) = [];
%     end
% %     lt.(l{1}) = struct2table(strc.(l{1}));
% end
%
% %% write to lt
% for i = 1:len
%     n = No(i);
%     l = Labels(i);
%     s = Sources(i);
% %     lt.(l{1}).(s{1})(end+1) = i;
%     lt.(l{1}).(s{1})(n,:) = i;
% end

end