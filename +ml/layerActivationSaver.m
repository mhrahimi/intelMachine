function layerActivationSaver(net, inputImage, layer, savingPath)

allActivations = activations(net,inputImage, layer);
imwrite(inputImage, fullfile(savingPath, ['input.jpg']));
for thisChannel = 1:length(allActivations(1,1,:))
    imageSize = size(inputImage);
    imageSize = imageSize([1 2]);
    
    thisChAct = allActivations(:,:,thisChannel);
    thisChAct = imresize(mat2gray(thisChAct),imageSize);
    imwrite(thisChAct, fullfile(savingPath, [num2str(thisChannel), '.jpg']));
    
    gifName = fullfile(savingPath, [layer, '.gif']);
    [A,map] = rgb2ind(repmat(thisChAct,1,1,3),256);
    if thisChannel == 1
        imwrite(A,map,gifName,'gif','LoopCount',Inf,'DelayTime',.5);
    else
        imwrite(A,map,gifName,'gif','WriteMode','append','DelayTime',.5);
    end
end

end