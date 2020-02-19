function [nos, nLogic, properties] = cutFilter(series, sampling)

load(DStools.propertiesPath);
cutsCounnt = length(propertiesDB);
allCuts = 1:cutsCounnt;
allOnes = ones(1,cutsCounnt);
allZeros = zeros(1,cutsCounnt);

%% series
allSeries = [propertiesDB.series];  % copying series to an array
if isa(series, 'function_handle')   % if thiInput is a function
    nLogic = series(allSeries);    
elseif isa(series, 'logical')       % if thiInput is a logical
    nLogic = series;
elseif all(isnan(series)) || isequal(series, '*') || all(series == -1) % if thiInput is an 'ALL' indicator
    nLogic = allOnes;
else    % if thiInput is an array of elements
%     nLogic = allOnes(series); 
    nLogic = allZeros;
    nLogic(series) = 1;
end
    
%% sampling
allSampling = [propertiesDB.sampling];
if isa(sampling, 'function_handle')   % if thiInput is a function
    nLogic = nLogic & sampling(allSampling);
elseif isa(sampling, 'logical')       % if thiInput is a logical
    nLogic = nLogic & sampling;
elseif isnan(sampling) || isequal(sampling, '*') || sampling == -1 % if thiInput is an 'ALL' indicator
    % doesn't affect
elseif isequal(sampling, '+') || isequal(sampling, '~') ||  sampling == 0 % if thiInput is an 'ligid or ~=-1' indicator
    sampling = @(x) x ~= -1;
    nLogic = nLogic & sampling(allSampling);    
else    % if thiInput is an array of elements
    samplingInd = allSampling == sampling;
    nLogic = nLogic & (allSampling .* samplingInd);  
end

%% output
nos = allCuts(nLogic);

if nargout > 2
    i = 1;
    S = zeros(length(nos),1);
    F = zeros(length(nos),1);
    numFlutes = zeros(length(nos),1);
    sampling = zeros(length(nos),1);;
    for cutNo = nos
        S(i) = propertiesDB(cutNo).cut.S;
        F(i) = propertiesDB(cutNo).cut.F;
        numFlutes(i) = propertiesDB(cutNo).tool.numFlutes;
        sampling(i) = propertiesDB(cutNo).sampling;
        
%         properties = table(S,F,numFlutes,sampling);
        
        i = i+1;
    end
    no = nos(:);
    properties = table(no, S,F,numFlutes,sampling);
end

clear propertiesDB

end