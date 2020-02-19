function [yCat, yLogic] = modelApply(x ,modelName)

if ischar(modelName) || isstring(modelName)
    model = load(fullfile(util.libRoot, '+ml', modelName));
    model = structfun((@(xx) xx), model);
elseif isstruct(modelName)
    model = modelName;
end

if ~istable(x)
    x = table(x);
end
x.Properties.VariableNames = model.RequiredVariables;

yCat = model.predictFcn(x);
yLogic = yCat == '1';

end