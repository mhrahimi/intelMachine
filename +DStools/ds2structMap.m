function structOut = ds2structMap(ds)

for i = 1:ds.Len
    s = ds.Sensors(i);
    l = ds.Labels(i);
    
%     structOut.(strjoin(["N", ds.No(i)],'')).(s{1}).(l{1}).Parts = i;
    structOut(ds.No(i)).(s{1}).(l{1}) = i;
end

end