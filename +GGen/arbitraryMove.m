function [code] = arbitraryMove(X, Y, Z, A, B)

code = [L];
if length(X)~=0
    code = [code Tab 'X' signChar(X) num2str(X)];
end
if length(Y)~=0
    code = [code Tab 'Y' signChar(Y) num2str(Y)];
end
if length(Z)~=0
    code = [code Tab 'Z' signChar(Z) num2str(Z)];
end
if length(A)~=0
    code = [code Tab 'A' signChar(A) num2str(A)];
end
if length(B)~=0
    code = [code Tab 'B' signChar(B) num2str(B)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using arbitraryMove function');
end

al(code);

end