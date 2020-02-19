function [code] = ARotate(A)

code = [L];
if length(A)~=0
    code = [code Tab 'A' signChar(A) num2str(A)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using ARotate function');
end

al(code);

end