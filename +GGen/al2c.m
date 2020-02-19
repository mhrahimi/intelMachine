% Add line to code

function [newCode] = al2c(code,lineToAdd)
%Add line to code
if length(code)>=1
    if lineToAdd(1) == '~'      % Add to the end of the same line
        newCode = [code ' ' lineToAdd(2:end)];
    else
        newCode = [code newline lineToAdd];
    end
else
    newCode = lineToAdd;
end

end

