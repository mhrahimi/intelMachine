function lt  =dsLookup(ds)

lUnique = unique(ds.Labels);
sUnique = unique(ds.Sensors);
len = ds.Len;
lt = struct();

%% empty table generation
for l = lUnique
    for s = sUnique
        lt.(l{1}).(s{1}) = [];
    end
%     lt.(l{1}) = struct2table(strc.(l{1}));
end

%% write to lt
for i = 1:len
    n = ds.No(i);
    l = ds.Labels(i);
    s = ds.Sensors(i);
%     lt.(l{1}).(s{1})(end+1) = i;
    lt.(l{1}).(s{1})(n,:) = i;
end

end