function code = singleAxisCodeGen(obj, axisChar, value, justCode)
code = [axisChar obj.signChar(value) num2str(value)];
if ~justCode
    obj.addLine(code, 1);
end
obj.last.(axisChar) = value;
end