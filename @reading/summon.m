function data = summon(obj, source, lable, number, subNumber)
% summon  Gets the source, lable, and number in order to read the
% coresponding data from permanent memory. -DataManipulation
%   data= summon(obj, source, lable, number, subNumber) Read the indexth data from the dataset from permanent
%   memory.
%
%   data = fetch(index, subIndex) (only for grinded datasets) Read the
%   subindex part of the indexth data from the dataset from permanent
%
%   See also SUMMON, FIND.

index = obj.LookupStruct.(source).(lable)(number);
data = obj.fetch(index);
end