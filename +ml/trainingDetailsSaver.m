function out = trainingDetailsSaver(input)
usingPersistentArrIsOn = 0;

if usingPersistentArrIsOn
    persistent trainingTable;
    if nargin == 0
        out = trainingTable;
        return
    end
    if isempty(trainingTable)
        trainingTable = input;
    else
        trainingTable = [trainingTable; input];
    end
    disp(trainingTable);
    if input.State == 'done'
        out = trainingTable;
    end
else
    tempFileName = '.trainingTable.csv';
    
    if nargin == 0 && exist(tempFileName)
        out = readtable(tempFileName);
        delete(tempFileName);
        return
    end
    
    if input.State == "start" && exist(tempFileName)
        delete(tempFileName);
    end
    
    if input.State == "start"
        writetable(struct2table(input, 'AsArray', true), tempFileName);
        
    elseif input.State ~= "start"
        out = input;
        iif = @(varargin) varargin{3-(varargin{1}>0)};
        empty2nan = @(x) iif(length(x) == 0, [NaN], x);
        thisStepArr = structfun(@(x) empty2nan(x), input,'UniformOutput',false);
        thisStepArr = struct2array(thisStepArr);
        thisStepArr(arrayfun(@ismissing,thisStepArr)) = '';
        
        fileID = fopen(tempFileName,'a');
        fprintf(fileID, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n', thisStepArr);
        fclose(fileID);
    end
end



end