
function obj = delete(obj, indices)
obj.No(indices) = [];
obj.File(indices) = [];
obj.Label(indices) = [];
obj.Source(indices) = [];
obj.Extention(indices) = [];
obj.BatchInd(indices) = [];
obj.BatchCount(indices) = [];

obj.Len = length(obj.File);
obj.ReadIndices = 1:obj.Len;

obj.Len = length(obj.File);
if obj.Len
    obj.Map = DStools.map(obj.No, obj.Source, obj.Label);
%     try
%         obj.Properties = [table(no','VariableNames',"No"), allProperties(no, :)];
%     catch
%         warning("Properties file NOT found!")
%     end
    
    obj.Labels = (categorical(obj.Label))';
end
end