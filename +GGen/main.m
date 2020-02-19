clear all 
clc

toolNumber = 0;         % Be careful about changing the tool #
spindelSpeed = 3000;
fastFeed = 2000;
cuttingFeed = 500;
precautionFeed = 300;

setGlobalTab(' ');
setGlobalLineStarter(['L' Tab]);
intializeTheCode('')

A = -10;

toolCall(toolNumber,spindelSpeed);
Mcode(3);
Mcode(126);
Mcode(128);
feed(fastFeed);
arbitraryMove('', '', '', A, '');

% al(lineDraw(0, 0, 20));
% al(lineDraw('', '', -6.5));
% al(lineDraw('', 150, ''));
% al(lineDraw('', '', 20));
% al(Mcode(5));
% al(Mcode(30));


Mcode(5);
Mcode(30);
disp(code)