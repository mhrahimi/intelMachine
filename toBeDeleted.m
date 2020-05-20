clc
close all
clear all

addpath("C:\Users\mhoss\Dropbox\Project MASc\Main");
%%
clc
dsParam.no = [210:278];
% dsParam.label = ["stable"];
dsParam.label = '*';
dsParam.source =  'Mic';
dsParam.extention = ".csv";
dsParam.dsPath = 'C:\Users\mhoss\Dropbox\Project MASc\Main\DS';

ds = reading(dsParam.no, dsParam.source, dsParam.label,...
    dsParam.extention, dsParam.dsPath);

spectogramParam.windowSize = 250;
spectogramParam.numOverlap = 50;
spectogramParam.nfft = spectogramParam.windowSize;
spectogramParam.size = [227, 227];
ds.TransformationFunction = @(x,y) spectogramGen(x, y, spectogramParam);
ds.TransformationIsOn = true;
ds.grinder(1000);

% sequences = datastore(ds);
% classes = ds.Label;
% sds = sequenceDatastore(ds.File);
%%
clc
MaxEpochs = 30;

% layers = [
%     imageInputLayer([3 1 1],"Name","imageinput")
%     fullyConnectedLayer(100,"Name","fc_1")
%     fullyConnectedLayer(100,"Name","fc_3")
%     fullyConnectedLayer(100,"Name","fc_4")
%     fullyConnectedLayer(100,"Name","fc_5")
%     fullyConnectedLayer(1,"Name","fc_2")
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classoutput")];

layers = [
    imageInputLayer([227 227 3],"Name","data")
    convolution2dLayer([11 11],96,"Name","conv1","BiasLearnRateFactor",2,"Stride",[4 4])
    reluLayer("Name","relu1")
    crossChannelNormalizationLayer(5,"Name","norm1","K",1)
    maxPooling2dLayer([3 3],"Name","pool1","Stride",[2 2])
    groupedConvolution2dLayer([5 5],128,2,"Name","conv2","BiasLearnRateFactor",2,"Padding",[2 2 2 2])
    reluLayer("Name","relu2")
    crossChannelNormalizationLayer(5,"Name","norm2","K",1)
    maxPooling2dLayer([3 3],"Name","pool2","Stride",[2 2])
    convolution2dLayer([3 3],384,"Name","conv3","BiasLearnRateFactor",2,"Padding",[1 1 1 1])
    reluLayer("Name","relu3")
    groupedConvolution2dLayer([3 3],192,2,"Name","conv4","BiasLearnRateFactor",2,"Padding",[1 1 1 1])
    reluLayer("Name","relu4")
    groupedConvolution2dLayer([3 3],128,2,"Name","conv5","BiasLearnRateFactor",2,"Padding",[1 1 1 1])
    reluLayer("Name","relu5")
    maxPooling2dLayer([3 3],"Name","pool5","Stride",[2 2])
    fullyConnectedLayer(4096,"Name","fc6","BiasLearnRateFactor",2)
    reluLayer("Name","relu6")
    dropoutLayer(0.5,"Name","drop6")
    fullyConnectedLayer(4096,"Name","fc7","BiasLearnRateFactor",2)
    reluLayer("Name","relu7")
    dropoutLayer(0.5,"Name","drop7")
    fullyConnectedLayer(numel(unique(ds.Label)),"Name","fc")
%     fullyConnectedLayer(1,"Name","fc")
%     regressionLayer()];
    softmaxLayer("Name","prob")
    classificationLayer("Name","output")];

options = trainingOptions('adam', ...
    'MaxEpochs',MaxEpochs, ...
    'GradientThreshold',2, ...
    'Shuffle', 'never', ...
    'Plots','training-progress');

net = trainNetwork(ds, layers, options);
% net = trainNetwork(XT,ca,layers,options);
%%
predictedLabels = classify(net, ds)

%%



















































