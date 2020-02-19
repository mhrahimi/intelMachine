function [theName, number, S, F, D, series] = fileNameHandler(fileName)

theName = strsplit(fileName, filesep);
theName = theName(end);
theName = char(convertStringsToChars(theName));
dashIndex = strfind(theName, '-');
SIndex = strfind(theName, '_S');
FIndex = strfind(theName, '_F');
DIndex = strfind(theName, '_D');
dotIndex = strfind(theName, '.');
if length(dotIndex) == 0
    dotIndex = length(theName);
end

number = str2num(theName(1:dashIndex(1)-1));
series = theName(dashIndex(1)+1:dashIndex(2)-1);
S = str2num(theName(SIndex+2:FIndex-1));
F = str2num(theName(FIndex+2:DIndex-1));
D = str2num(erase(theName(DIndex+2:dotIndex),["_"]));

end