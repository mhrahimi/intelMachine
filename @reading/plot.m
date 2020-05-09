function plot(obj, ind, options)
showLabels = 0;

time = 0;
if nargin <= 2
    options = '';
end
if isfield(options, 'Labeling')
    showLabels = options.Labeling;
    options = rmfield(options, 'Labeling');
end
for i = ind
    thisData = obj.fetch(i);
    thisProperties = obj.propertiesFetch(i);
    if isfield(thisProperties, 'sampling')
        Fs = 1/thisProperties.sampling;
    else
        Fs = 1;
    end
    time = time(end) + [0:Fs:(length(thisData)-1)*Fs];
    plot(time, thisData, options);
    hold on
    if showLabels
        xline(time(end), 'blue --', thisProperties.Label{1},...
            'LabelHorizontalAlignment', 'left');
    end
end
xlim([0,time(end)]);
hold off
end