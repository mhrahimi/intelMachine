function [out] = functionName(f, cut, sensor, label, plottingIsOn)
%% importin the lib
import intelMachine.DBtools.*
%% loading the DBs
ldbInput = DBtools.dbLoader('labeledDB');
labels = DBtools.dbLoader('labelsDB');          % move it to the isPlottingOn scope, for optimization, gotta change a few thind beforehand
properties = DBtools.dbLoader('propertiesDB');  % move it to the isPlottingOn scope, for optimization, gotta change a few thind beforehand
%% check the inputs
if nargin < 1 || isempty(f)
    f = @(x) x;
else
    numFun = length(f);
end

if nargin < 2 || isequal(cut, 'all') || isempty(cut)
    numCut = length(ldbInput);
    cut = 1:length(ldbInput);
else
    numCut = length(cut);
end

if nargin < 5 
    plottingIsOn = 0;
end
if nargin < 3 || isequal(sensor, 'all') || isempty(sensor)
    numSen = length(properties(1).sensors);
    sensor = 1:length(properties(1).sensors);
else
    numSen = length(sensor);
end

if nargin < 4 || isequal(label, 'all') || isempty(label)
    numLab = length(DBtools.ndb(cut(1),labels));
    label = 1:length(DBtools.ndb(cut(1),labels));
else
    numLab = length(label);
end

%% the real stuff!!
out = cell(numCut, numSen, numLab);
rawData = cell(numCut, numSen, numLab);

ic = 1; 
for c = cut
    if nargin < 3 || isequal(sensor, 'all') || isempty(sensor)
        sensor = 1:length(properties(c).sensors);
    end
    if nargin < 4 || isequal(label, 'all') || isempty(label)
        label = 1:length(DBtools.ndb(cut(1),labels));
    end
    is = 1; 
    for s = sensor
        il = 1;
        for l = label
            temp = DBtools.ldb(c, s, l, ldbInput);
            rawData(ic, is, il) = {temp};
            out(ic, is, il) = {f(temp)};
            
            il = il + 1;
        end
        is = is + 1;
    end
    ic = ic + 1;
end

%% plotting
if plottingIsOn
    ic = 1;
    for c = cut
        subi= 1;
        fig(ic) = figure;
        suptitle(['Cut #', num2str(c)]);
        senName = properties(c).sensors;
        numLab = length(label);
        numSen = length(sensor);
        
        % determine if the first sensor is time
%         linearityThreshold = (10^-5);
        timeIsAvailable = 0;
%         firstSensor = cell2mat(squeeze(out(c, 1, :)));
%         if std(diff(firstSensor)) < linearityThreshold         % measure the linearity
%             timeIsAvailable = 1;
%             sensorModified = sensor(2:end);
%             is = 2;
%             numSen = numSen-1;
%         else % not having time circumstances
            sensorModified = sensor;
            is = 1;
%         end
        
        for s = sensorModified
            yMax = max(cell2mat(squeeze(out(ic, is, :))));
            yMin = min(cell2mat(squeeze(out(ic, is, :))));
            
            
            il = 1;
            for l = label
                subplot(numSen,numLab, subi);
                
                outMat = cell2mat(out(ic, is, il));
                if timeIsAvailable
                    time = cell2mat(squeeze(out(ic, 1, l)));
                    plot(time, outMat);
                else
                    plot(outMat);
                end
                
                set(gca,'XTick',[]);
                ylim([yMin yMax]);
%                 set(gca,'visible','off')
                if is == 1
                    title(DBtools.ndb([c,l],labels));
                end
                if il == 1
                    yl = ylabel(properties(c).sensors(is));
                    set(get(gca,'ylabel'),'rotation',0);
                    yl.Position(2) = yl.Position(2);
                else
                    set(gca,'YTick',[]);
                end
                
                subi = subi + 1;
                il = il + 1;
            end
            is = is + 1;
        end
        ic = ic + 1;
    end
end


















































end



