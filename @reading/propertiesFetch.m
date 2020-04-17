function properties = propertiesFetch(obj, index, varargin)
propertiesIndex = (obj.Properties.No == obj.No(index));
properties = table2struct(obj.Properties(propertiesIndex,:));

properties.File = obj.File(index);
% properties.No = obj.No(index);
properties.Label = obj.Label(index);
properties.Source = obj.Source(index);
properties.Extention = obj.Extention(index);

for i = 1:2:length(varargin)
    properties.(varargin{i}) = varargin{i+1};
end
end