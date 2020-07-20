function [performance, Confusion, classes] = netAssess(net, ds)
classes.true = ds.Labels;
classes.pred = classify(net,ds);

Confusion.NromVal = ml.confMat(classes.true, classes.pred);
performance.err = ml.netErr(classes.true, classes.pred);
[performance.meanF1, performance.f1Scores, performance.precision, performance.recall, ... 
Confusion.Mat, Confusion.labels, Confusion.struct] =...
ml.measureOfAccuracy(classes.true, classes.pred);
end