function code = end(obj)
code = ['END PGM ' upper(obj.programName) ' ' upper(obj.units)];
if nargout == 0
obj.addLine(code);
end
end