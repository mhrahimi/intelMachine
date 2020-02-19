function peaksInd = manualPeakPicker(y, stickyPoints)

x= 1:length(y);
x = x';
y = normalize(y, 'range');
y = y*length(y);

plot(y);
hold on
plot(x(stickyPoints), y(stickyPoints), 'red O');
s = [x(stickyPoints), y(stickyPoints)];

button = 1;
i=1;
while button ~= 3
    [inX, inY, button] = ginput(1);
    closest = dsearchn(s, [inX inY]);
    
    if button ~= 3
        peakValue(i,:) = [s(closest,1), s(closest, 2)];
        plot(peakValue(i,1),peakValue(i,2), 'green *');
        peaksInd(i) = peakValue(i,1);
        i = i+1;
    end
end


hold off
end