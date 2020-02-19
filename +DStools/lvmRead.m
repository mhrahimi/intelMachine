function [table, details] = lvmRead(fileAdd)

writeTableIsOn = 0;
saveAsTableIsOn = 0;

fileText = fileread(fileAdd);

fileName = strsplit(fileAdd, '/');      % get rid of the address
fileName = strsplit(char(fileName(end)), '.');  % get rid of the extention
fileName = char(fileName(1));
% fileName = [char(fileName(1)), '.dat'];
% i = 1;
% while filetext(i:i+19) ~= "***End_of_Header**"
%     i = i + 1;
% end

isLabView = (length(strfind(fileText,'LabVIEW Measurement	') == 1));
if ~isLabView
    warning([fileName, ' is not a LabView Measurment file!'])
end

if isLabView
dateIndexS = strfind(fileText,'Date	');
dateIndexE = strfind(fileText,'Time	');
details.date = fileText(dateIndexS(1)+5:dateIndexE(1)-3);

timeIndexS = dateIndexE;
timeIndexE = strfind(fileText,'***End_of_Header***	');
details.time = fileText(timeIndexS(1)+5:timeIndexE(1)-3);

unitsIndexS = strfind(fileText,'Y_Unit_Label');
unitsIndexE = strfind(fileText,'X_Dimension');

units = strsplit(fileText(unitsIndexS+13:unitsIndexE-4),'	');
units = [{'s'}, units];

titlesIndexS = strfind(fileText,'X_Value');
titlesIndexE = strfind(fileText,'Comment');

titles = strsplit(fileText(titlesIndexS:titlesIndexE+6),'	');

dataIndexS = strfind(fileText, 'X_Value');

% getting ride of the comment section as well as header
% to-do: !I DID NOT ACCOUNT FOR COMMENT TEXT!
commentIndexS = strfind(fileText, '	Comment');
fileText = [fileText(dataIndexS:commentIndexS), fileText(commentIndexS+8:end)];
% fileTextLines = strsplit(fileText,newline);
fid = fopen([fileName, '.csv'], 'w');
fprintf(fid, fileText);
fclose(fid);

table = readtable([fileName, '.csv']);
% extract and write the titles
% fileTextLinesChar = char(fileTextLines(1));
% fileTextLinesChar = fileTextLinesChar(1:end-2);  % eliminate enter at the end
% fileTextCells(1,:) = strsplit(fileTextLinesChar,'	');
% table = cell2table(cell(0,length(fileTextCells(1,:))), 'VariableNames', fileTextCells(1,:));

% bar = waitbar(0, ['Please wait...', newline, '(Converting to table)']);
% numOfRow = length(fileTextLines);
% for i=2:numOfRow-1
%     fileTextLinesChar = char(fileTextLines(i));
%     fileTextLinesChar = fileTextLinesChar(1:end-2);  % eliminate enter at the end
%     fileTextCells(i,:) = strsplit(fileTextLinesChar,'	');
%     fileTextCellsNum(i,:) = str2double(fileTextCells(i,:));
%     table = [table;  num2cell(fileTextCellsNum(i,:))];
%     
%     waitbar(i/numOfRow);
% end


table.Properties.VariableUnits = units;
table.Properties.VariableNames = titles(1:end-1);

if ~writeTableIsOn
    delete([fileName , '.csv']);
end

if saveAsTableIsOn
    save(fileName, 'table');
end

% close(bar)
else
    table = [];
    details = '';
%     details.date = '';
%     details.time = '';
end

end