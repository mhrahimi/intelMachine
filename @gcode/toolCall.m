function [code] = toolCall(obj, toolNumber,spindleSpeed)
code = ['TOOL' obj.driver.spc 'CALL' obj.driver.spc num2str(toolNumber)...
    obj.driver.spc];
if toolNumber ~= 0
    warning(['YOU ARE CALLING TOOL #' str2num(toolNumber) '!'])
end

if nargin == 3
    code = [code obj.S(spindleSpeed)];
end

if nargout == 0
%     obj.addLine(code);
    obj.addLine(code);
end

end

