function [testError, accuracy, testPredLabels] = netQualification(trainedNet, testImgs)

testPredLabels = classify(trainedNet,testImgs);
testTrueLabels = testImgs.Labels;

testError = ml.netErr(testTrueLabels, testPredLabels);
[~, ~, ~, ~, ~, ~, accuracy] = ml.measureOfAccuracy(testTrueLabels, testPredLabels);

end