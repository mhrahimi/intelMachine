function [out, report] = quickEnd(fileName)
import GGen.*

if nargin <= 1
    fileName = 'GGenGeneratedGCode.txt';
end

Mcode(5);
Mcode(30);
programEnd(fileName, 'mm');

out = code;


% writeToFile(fileName,out)
% report = reportGen;

end