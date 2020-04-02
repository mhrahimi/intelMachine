clear all
clc

no = [1:10];
source = ["Mic", "AccelerationY"];
% source = '*';
% label = ["chatter", "stable", "chatterInit"];
label = '*';
extention = ".csv";
dsPath = "C:\Users\mhoss\Dropbox\Project MASc\Refactor\intelMachine\DS";

a = reading(no, source, label, extention, dsPath);

% plot(a.fetch("Mic", "chatter", 1))
% plot(a.summon(a.LookupStruct.Mic.chatter(3)))
a.grinder(4, 1)

a.filteringIsOn = 1;
a.filteringFunction = @(x) x*100;

a