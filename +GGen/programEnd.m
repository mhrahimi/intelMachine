function [code] = programEnd(programName, units)
import GGen.*

code = ['END PGM ' upper(programName) ' ' upper(units)];

al(code);

end