function [ds, properties] = dsGenPlus(series, sampling, sensor, label)

if nargin <= 3  % filtering function is not active
    % shifting all of the input varibles to left (for compatibility with
    % dsGen)
    if isequal(series, "all") || all(series == -1)
        no = '*';
    end
    
    if nargin <2 || isequal(sampling, "all") || (isnumeric(sampling) && all(sampling == -1))
        sensor = '*';
    end
    
    if nargin<3 || isequal(sensor, "all") || (isnumeric(sensor) && all(sensor == -1))
        label = '*';
    end
    
    no = series;
    sensor = sampling;
    label = sensor;
elseif nargin == 4 % filtering function is not active
    [no, ~, properties] = DStools.cutFilter(series, sampling);
    
    if isequal(no, "all") || isequal(no, "*") || all(no == -1)
        no = '*';
    end
    
    if nargin <2 || isequal(sensor, "all") || isequal(sensor, "*") || (isnumeric(sensor) && all(sensor == -1))
        sensor = '*';
    end
    
    if nargin<3 || isequal(label, "all") || isequal(label, "*") || (isnumeric(label) && all(label == -1))
        label = '*';
    end
else
    warning('something is wrong with dsGenPlus function');
end
ds = DStools.dsGen(no, sensor, label);
end