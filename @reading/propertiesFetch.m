function properties = propertiesFetch(obj, index)
properties = table2struct(properties(index,:));
properties.File = obj.File;
properties.No = obj.No;
properties.Label = obj.Label;
properties.Source = obj.Source;
properties.Extention = obj.Extention;
end