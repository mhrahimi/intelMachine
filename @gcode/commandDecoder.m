function code = commandDecoder(obj, command, value)
switch lower(command)
    case 'x'
        code = obj.X(value);
    case 'y'
        code = obj.Y(value);
    case 'z'
        code = obj.Z(value);
    case 'a'
        code = obj.A(value);
    case 'b'
        code = obj.B(value);
    case 'f'
        code = obj.F(value);
    case 'comment'
        code = obj.comment(value);
    otherwise
        warning(strjoin(["Unknown input to 'commandDecoder' command! - '", ...
            command, "' is not a gcode library command"]));
        code = [command, value];
end
if nargout == 0
    obj.addLine(command);
end
end