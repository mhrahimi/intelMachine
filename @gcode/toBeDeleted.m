clear all
clear classes
clc
close all

gc = gcode;
gc.cuttingFeed = 6000;

gc.move.y(543).x(11430).A(31).B(321).f(100);
gc.feed.faST;
gc.move.y(57).x(110).A(9870).B(76);
gc.move(1,2,3,4,5);
gc.move(1,2,3,4,5,999,'assa');
gc.code
gc.log
disp(gc);

%%
lineCode = '5 L X20 Y10 Z04 A31 B55 ;ZeroPosition ';

components