function [output, time, properties] = dsRead(n, sensor, axis, label, varargin)
% dbRead  Read a data point from an index of database.
%   [output, time, properties] = dbRead(dataSetIndex, dataIndex) Backward
%   compatibility - Matching dbRead function, for a numeric sensor input,
%   the axis input does not matter.
%
%   See also glimps, mPlotter, lvmRead.


%% Backward compatibility - Matching dbRead function
if isnumeric(sensor)
    sensorNames = ["Time", "Acceleration", "Acceleration", "Acceleration", "Mic", "Current", "Current", "Current", "Dynamometer", "Dynamometer", "Dynamometer"];
    sensor = sensorNames(sensor+1);
    
    axisNames = ["", "x", "y", "z", "", "spin50", "spin100", "Y","x", "y", "z"];
    axis = axisNames(sensor+1);
end
if isnumeric(label)
    labelNames = ["air", "entrance", "stable", "chatterInit", "chatter", "exit", "air"];
    label = labelNames(label);
end

%% pre-setup the vriables







end



















































