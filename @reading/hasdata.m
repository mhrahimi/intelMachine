% Matlab ds compatibility
function output = hasdata(obj, input)
if nargin == 1
    if obj.head <= obj.Len
        output = true;
    else
        output = false;
    end
    if obj.debuggingIsOn
        disp(obj.head);
    end
elseif nargin == 2
    if ~isempty(input) & input.head <= input.Len
        output = true;
    else
        output = false;
    end
    if obj.debuggingIsOn
        disp(input.head);
    end
end
end
