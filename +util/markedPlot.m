function pHandle = markedPlot(Y, markedPoints, X, basePlotDrawingIsOn, vargin)

%% plot properties
if nargin < 4
    vargin = 'O red';
end

%% logistics
if iscategorical(markedPoints)
    markedPoints = markedPoints == '1';
end

%% basePlotDrawingIsOn
if nargin < 4
    basePlotDrawingIsOn = 1;
end

%% drawing the base plot
if nargin < 3 & basePlotDrawingIsOn
    plot(Y);
elseif basePlotDrawingIsOn
    plot(X, Y);
end

%% marking the points
hold on;
if nargin < 3 % no X input
    yIndexed = [(1:length(Y))' Y];
    yIndexed = yIndexed(markedPoints,:);
    pHandle = plot(yIndexed(:,1),yIndexed(:,2),vargin);
else % with X input
    yIndexed = [X Y];
    yIndexed = yIndexed(markedPoints,:);
    pHandle = plot(yIndexed(:,1),yIndexed(:,2),vargin);
end
hold off
end