function code = curve(obj, x, y, z, direction)
direction = char(direction);
code = obj.singleAxisCodeGen('X', x, nargout);
code = [code, ' ', obj.singleAxisCodeGen('Y', y, nargout)];
code = [code, ' ', obj.singleAxisCodeGen('Z', z, nargout)];
code = [direction, code];

obj.addLine(code);
end