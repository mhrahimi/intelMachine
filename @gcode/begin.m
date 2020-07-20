function code = begin(obj, programNameIn, unitsIn)
if nargin == 3
    obj.programName = programNameIn;
    obj.units = unitsIn;
elseif nargin == 2
    obj.programName = programNameIn;
    obj.units = 'NA';
elseif nargin == 1
    obj.programName = ['UNNAMMED', date];
    obj.units = 'NA';
end

code = ['BEGIN PGM ' upper(obj.programName) ' ' upper(obj.units)];
if nargout == 0
    obj.addLine(code);
end
end