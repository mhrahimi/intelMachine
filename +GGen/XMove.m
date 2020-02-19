function [code] = XMove(X)
import GGen.*

code = [L];
if length(X)~=0
    code = [code Tab 'X' signChar(X) num2str(X)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using XMove function');
end

al(code);

end