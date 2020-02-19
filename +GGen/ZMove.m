function [code] = ZMove(Z)
import GGen.*
code = [L];
if length(Z)~=0
    code = [code Tab 'Z' signChar(Z) num2str(Z)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using ZMove function');
end

al(code);

end