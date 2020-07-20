function out = quickStart(cuttingfeed, spindelSpeed, programName, toolNumber)
% TODO: add vargin to chage the progrme name style, the units and arbitary
% MCodes
import GGen.*

if nargin <=3
    toolNumber = 0;
    if nargin <= 2
        programName = 'GGenGenratedGCode';
    end
end

[y,m,d] = ymd(datetime);
programName = [programName, '_', num2str(y), '_', num2str(m), '_', num2str(d)];

setGlobalFeeds(cuttingfeed);
setGlobalTab(' ');
setGlobalLineStarter(['L']);
intializeTheCode('');

programBegin(programName, 'mm');
toolCall(toolNumber,spindelSpeed);
Mcode(3);
Mcode(126);

out = code;

end