function code = comment(obj, txt)
code = [';' txt];
if nargout == 0
    obj.addToLine(code);
end
end