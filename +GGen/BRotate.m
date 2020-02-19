function [code] = BRotate(B)

code = [L];
if length(B)~=0
    code = [code Tab 'B' signChar(B) num2str(B)]
end

if strcmpi(code , 'L ')
    warning('You added a void line using BRotate function');
end

al(code);

end