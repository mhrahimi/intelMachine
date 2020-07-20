function startup(obj)
% log
obj.log = array2table(zeros(0,7));
obj.log.Properties.VariableNames = {'X','Y','Z','A','B','F','S'};
% last
obj.last.X = NaN;
obj.last.Y = NaN;
obj.last.Z = NaN;
obj.last.A = NaN;
obj.last.B = NaN;
obj.last.F = NaN;
obj.last.S = NaN;
% driver load
obj.driver.spc = ' ';
obj.driver.l = 'L';
end