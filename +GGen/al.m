

function al(lineToAdd)

global code
global lineNumber

lineNumbrStr = num2str(lineNumber);

if length(code)>=1
    if lineToAdd(1) == '~'      % Add to the end of the same line
        code = [code ' ' lineToAdd(2:end)];
    else
        code = [code newline lineNumbrStr ' ' lineToAdd];
        lineNumber = lineNumber + 1;
    end
else
    code = [lineNumbrStr ' ' lineToAdd];
    lineNumber = lineNumber + 1;
end



end

