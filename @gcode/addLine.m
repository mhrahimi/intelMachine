function addLine(obj, codeLine, loopCycle)
comment = [];
if strfind(codeLine, ';') % move comment to the end of the line
    semicolonPos = strfind(codeLine, ';');
    comment = codeLine(semicolonPos:end);
    codeLine = codeLine(1:semicolonPos-1);
end
if ~isnan(obj.feedrateUpdate)
    codeLine = [codeLine, ' F', num2str(obj.feedrateUpdate)];
    obj.feedrateUpdate = NaN;
end
if ~isnan(obj.spindleSpeedUpdate)
    codeLine = [codeLine, ' S', num2str(obj.spindleSpeedUpdate)];
    obj.spindleSpeedUpdate = NaN;
end

if 3 <= nargin % if loop cycle exists
    if loopCycle == 1
        codeLine = [obj.driver.l obj.driver.spc codeLine];
    else
        codeLine = [obj.driver.l num2str(loopCycle) obj.driver.spc codeLine];
    end
end

codeLine = [codeLine, comment]; % move comment to the end of the line
obj.code{obj.lineIt} = codeLine;
obj.logger;
obj.lineIt = obj.lineIt + 1;
end

