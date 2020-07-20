function code = M(obj, number)
code = ['M' num2str(number)];
if nargout == 0
    obj.addLine(code);
end
end

