function code = S(obj, s)
code = ['S' num2str(s)];
obj.last.S = s;
spindleSpeedUpdate = NaN;
if nargout == 0
    obj.spindleSpeedUpdate = s;
end
end