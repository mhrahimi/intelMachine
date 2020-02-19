function t = nestedStruct2table(nestedStruct)
maxLength = 0;

outerStructFields = fieldnames(nestedStruct);
for i = 1:length(outerStructFields)
    maxInnerLength = 0;
    
    f1 = outerStructFields{i};
    innerStructFields = fieldnames(nestedStruct.(f1));
    for j = 1:length(innerStructFields)
        f2 = innerStructFields{j};
        maxInnerLength = max(length(nestedStruct.(f1).(f2)),maxInnerLength);
    end
    for j = 1:length(innerStructFields)
        f2 = innerStructFields{j};
        if length(nestedStruct.(f1).(f2)) ~= maxInnerLength
            nestedStruct.(f1).(f2)(maxInnerLength,:) = 0;
        end
    end
    nestedStruct.(f1) = struct2table(nestedStruct.(f1));
    maxLength = max(height(nestedStruct.(f1)), maxLength);
end
for i = 1:length(outerStructFields)
    f1 = outerStructFields{i};
    if height(nestedStruct.(f1)) ~= maxLength
        nestedStruct.(f1)(maxLength,end) = table(0);
    end
end

t = struct2table(nestedStruct);
end