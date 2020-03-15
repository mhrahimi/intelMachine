function keyArray = numberMapper(valueSet)

valueSet = unique(valueSet);
keyArray = containers.Map(valueSet,[1:length(valueSet)]);

end