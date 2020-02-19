function [code] = toolCall(toolNumber,spindelSpeed)
import GGen.*
code = ['TOOL' Tab 'CALL' Tab num2str(toolNumber) Tab 'S' num2str(spindelSpeed)];
if toolNumber ~= 0
    warning(['YOU ARE CALLING TOOL #' toolNumber '!'])
end

al(code);

end

