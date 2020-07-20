function subDS = cp(ds, indicies)
warning('off')
subDS = reading();
warning('on')

subDS.File = ds.File(indicies);
subDS.No = ds.No(indicies);
subDS.Label = ds.Label(indicies);
subDS.Source = ds.Source(indicies);
subDS.Extention = ds.Extention(indicies);
subDS.Len = length(indicies);

subDS.Labels = ds.Labels(indicies);

%             subDS.Properties = ds.Properties(indicies,:);
%             subDS.Properties = table();
%             for thisNo = unique(subDS.No)
%                 subDS.Properties = [subDS.Properties;...
%                     struct2table(ds.propertiesFetch(thisNo))];
%             end
subDS.Properties = ds.Properties;

subDS.FilteringIsOn = ds.FilteringIsOn;
subDS.TransformationIsOn = ds.TransformationIsOn;

subDS.BatchInd = ds.BatchInd(indicies);
subDS.BatchCount = ds.BatchCount(indicies);

subDS.isGrinded = ds.isGrinded;
subDS.readingFunction = ds.readingFunction;
end
