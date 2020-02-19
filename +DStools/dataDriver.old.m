function newTable = dataDriver(data)
% dataDriver  read from the raw data "database.mat" and process them to the
% final data.
%   newTable = dataDriver(data) data is the table of raw data. The function will process whole table each time.
%


[titles, sensorName, units, sensorPort, sensorSpec] = tableExtracter(data);
dataMatrix = table2array(data);

milli = 10^-3;

deafualtC.acceleration.B13 = 1/(100*milli);
deafualtC.Mic.noChange = 1;
deafualtC.current.zenU2_50A = 50/5;
deafualtC.current.zenU2_100A = 100/5;
deafualtC.current.i310 = (milli);
deafualtC.Dynamometer.default = 1;          % Incorrect
deafualtC.Trigger = 2.5;

for i=1:length(titles)
    switch char(sensorName(i))
        case 'time'
            data.Properties.VariableNames(i) = {'time'};
            data.Properties.VariableUnits(i) = {'s'};
        case 'Acceleration'
            dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.acceleration.B13;
        case 'Mic'
            dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.Mic.noChange;
        case 'Current'
            switch char(sensorSpec(i))
                case 'Spin50A'
                    dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.current.zenU2_50A;
                case 'Spin100A'
                    dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.current.zenU2_100A;
                case 'Y'
                    dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.current.i310;
                otherwise
                    warning('UNKNOWN current sensor');
            end
        case 'Dynamometer'
            dataMatrix(:,i) = dataMatrix(:,i) * deafualtC.Dynamometer.default;
            units(i) = {'newton'};
        case 'Trigger'
            dataMatrix(:,i) = (dataMatrix(:,i) >= deafualtC.Trigger);
            units(i) = {'bool'};
            
        otherwise
            warning('dataDrive: UNKNOWN sensor');              
    end
    newTable = array2table(dataMatrix);
    newTable.Properties.VariableNames = titles;
    newTable.Properties.VariableDescriptions = append(sensorName , '_', sensorSpec);
    newTable.Properties.VariableUnits = units;
    
    
    
end
end