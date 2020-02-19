function [code] = programBegin(programName, units)
import GGen.*
code = ['BEGIN PGM ' upper(programName) ' ' upper(units)];

al(code);

end