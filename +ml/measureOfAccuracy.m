function [meanF1, f1Scores, precision, recall, confusionMat, confucionMatLabels, accStruct] = measureOfAccuracy(realLabels, predictedLables)

[confusionMat, confucionMatLabels] = confusionmat(realLabels, predictedLables);

precision = diag(confusionMat')./sum(confusionMat',2);
recall = diag(confusionMat')./sum(confusionMat',1)';

f1Scores = 2*(precision.*recall)./(precision+recall);
meanF1 = mean(f1Scores);

if 7 <= nargout
    accStruct.confusionMat = confusionMat;
    accStruct.labels = confucionMatLabels;
    accStruct.recall = recall;
    accStruct.precision = precision;
    accStruct.f1Scores = f1Scores;
    accStruct.meanF1 = meanF1;
end

end