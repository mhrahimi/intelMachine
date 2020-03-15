function numLines = fileLineCount(fileAdd)
fh = fopen(fileAdd, 'rt');
assert(fh ~= -1, 'Could not read: %s', fileAdd);
x = onCleanup(@() fclose(fh));
numLines = 0;
while ~feof(fh)
    numLines = numLines + sum( fread( fh, 16384, 'char' ) == char(10) );
end
end

% exact replica of https://stackoverflow.com/a/12177413/3940670
