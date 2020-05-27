function data = readall(obj)
data = cell(obj.Len, 1);
i = 1;
for i = 1:obj.Len
    data(i,1) = obj.fetch(i);
end
end