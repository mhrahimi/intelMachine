function [code] = YMove(Y)
import GGen.*

code = [L];
if length(Y)~=0
    code = [code Tab 'Y' signChar(Y) num2str(Y)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using YMove function');
end

al(code);

end