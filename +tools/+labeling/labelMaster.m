function [lineX] = labelMaster(data, label)

% lables = ["aircut", "entrance", "inCut", "chatter", "exit", "envNoise"];
plot(data);
lineX = zeros(length(label),1);

labelIt = 1;
% xlabel('Modification - Press any key to continue...');
xline(lineX(1),'-',label(1));
% while ~waitforbuttonpress
% end
while labelIt<length(label)
    xlabel([label(labelIt+1), 'Press any key to continue...']);
    while ~waitforbuttonpress   end
    button = 0;
    xlabel('Select a point or press del for undo');
    [x,y,button] = ginput(1);
    labelIt = labelIt+1;
    switch button
        case {1, 32} % adding a new section - clicking or pressing spacebar
            lineX(labelIt) = x;
            xline(lineX(labelIt),'-',label(labelIt));
        case {8, 127}   % deleting last section - pressing del ot backspace
            if labelIt-2 <1
                xlabel('There is no section to be deleted');
            else
                labelIt = labelIt-2
                clf
                plot(data);
                xlabel('deleted');
                for j = 1:labelIt         % redrawing the lines
                    xline(lineX(j),'-',label(j));
                end
            end
    end
    
end
xlabel('Done!');

end