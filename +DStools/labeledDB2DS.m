function labeledDB2DS(t, labels, sensors, extention)

[height, width] = size(t);

% sensors = ["Time", "Acceleration", "Acceleration", "Acceleration", "Mic", "Current", "Current", "Current", "Dynamometer", "Dynamometer", "Dynamometer"];
% axis = ["", "x", "y", "z", "", "spin50", "spin100", "Y","x", "y", "z"];
% units = ["s", "g", "g", "g", "pascals", "volts", "volts", "volts", "volts", "volts", "volts"];
sensors = ["Time", "AccelerationX", "AccelerationY", "AccelerationZ", "Mic", "CurrentSpin50", "CurrentSpin100", "CurrentY", "DynamometerX", "DynamometerY", "DynamometerZ"];
labels = ["air", "entrance", "stable", "chatterInit", "chatter", "exit", "air"];
extention = ".csv";

%% DS path identification
dsPath = mfilename('fullpath');
fileSepLoc = strfind(dsPath, filesep);
dsPath = dsPath(1:fileSepLoc(end-1));
dsPath = fullfile(dsPath, "DS");

%% folder generatoin
for l = labels
    mkdir(fullfile(dsPath, l));
end

%% file write
for n = 1:height
    for l = 1:width
        measurment = t{n, l};
        if ~all(isempty(measurment(:,:)))
            for s = 1: length(sensors)
                name = DStools.dsNameGen(n, sensors(s), labels(l), extention);
                fileAdd = fullfile(dsPath, labels(l), name); % dsPath+label+fileName
                arr = table2array(measurment(:,s));
                writematrix(arr, fileAdd);
            end
        end
    end
end
end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
