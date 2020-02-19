
% net = trainedNet;
inputImage = imread("C:\Users\mhoss\Dropbox\Project MASc\Refactor\CNN\2 scenarios\datastore\chatter\N_57.0022_S_AccelerationY_L_chatter_.jpg");
savingPath = 'C:\Users\mhoss\Dropbox\0Seminar\Convolution\pics';
% ml.layerActivationSaver(trainedNet, inputImage, layer, channel,'C:\Users\mhoss\Dropbox\0Seminar\Convolution\Layers\1');
for i = 2:length(net.Layers)
    layer = net.Layers(i).Name;
    thisDir = fullfile(savingPath, [num2str(i), '-', layer]);
    mkdir(thisDir);
    ml.layerActivationSaver(net, inputImage, layer, thisDir);
    
    allActivations = activations(net,inputImage, layer);
    montagePic = montage((allActivations), 'Size', tools.squaredSize(size(allActivations,3)));
    montagePic = getframe(gca);
    imwrite(montagePic.cdata, [thisDir, '-montage.jpg']);
end