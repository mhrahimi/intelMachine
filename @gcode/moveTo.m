function [code] = moveTo(XYZAC)

code = [L];

X = ''; Y = ''; Z = ''; A=''; C = '';

if class(XYZAC) == 'struct'
    if isfield(XYZAC, 'x')
        X = XYZAC.x;
    elseif isfield(XYZAC, 'X')
        X = XYZAC.X;
    end
    if isfield(XYZAC, 'y')
        Y = XYZAC.y;
    elseif isfield(XYZAC, 'Y')
        Y = XYZAC.Y;
    end
    if isfield(XYZAC, 'z')
        Z = XYZAC.z;
    elseif isfield(XYZAC, 'Z')
        Z = XYZAC.Z;
    end
    if isfield(XYZAC, 'A')
        A = XYZAC.A;
    elseif isfield(XYZAC, 'a')
        A = XYZAC.a;
    end
    if isfield(XYZAC, 'C')
        C = XYZAC.C;
    elseif isfield(XYZAC, 'c')
        C = XYZAC.c;
    end
    
elseif class(XYZAC) == 'double'
    X = XYZAC(1);   Y = XYZAC(2);   Z = XYZAC(3);
    if length(XYZAC) > 3
        A = XYZAC(4);
        if length(XYZAC) >4
            C = XYZAC(5);
        end
    end
end

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
if length(C)~=0
    code = [code Tab 'C' signChar(C) num2str(C)];
end

if strcmpi(code , 'L ')
    warning('You added a void line using moveTo function');
end

al(code);

end