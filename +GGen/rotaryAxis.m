function [code] = rotaryAxis(A, B)

code = [L];

if length(A)~=0
    code = [code Tab 'A' signChar(A) num2str(A)];
end
if length(B)~=0
    code = [code Tab 'B' signChar(B) num2str(B)];
end

al(code);

end