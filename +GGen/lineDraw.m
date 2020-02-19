function [code] = lineDraw(X, Y, Z)

import GGen.*

code = [L];
if length(X)~=0
    code = [code Tab 'X' signChar(X) num2str(X)];
end
if nargin >= 2 && length(Y)~=0
    code = [code Tab 'Y' signChar(Y) num2str(Y)];
end
if nargin >= 3 && length(Z)~=0
    code = [code Tab 'Z' signChar(Z) num2str(Z)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using lineDraw function');
end


al(code);


end

