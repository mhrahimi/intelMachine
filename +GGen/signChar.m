function [signCh] = signChar(number)

if sign(number) == +1
    signCh = '+';
else
    signCh = '';
end

end

