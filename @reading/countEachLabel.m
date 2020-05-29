function output = countEachLabel
Label = unique(obj.Label);
Count = count(obj.Label, Label);
output = table(Label, Count);
end