function [channelActivation, allActivations] = channelActivation(net, inputImage, layer, channel)
%% activation calculation
allActivations = activations(net,inputImage, layer);
%% for one channel
if 4 <= nargin
    imageSize = size(inputImage);
    imageSize = imageSize([1 2]);
    
    channelActivation = allActivations(:,:,channel);
    channelActivation = imresize(mat2gray(channelActivation),imageSize);
    if nargout == 0
        imshowpair(inputImage,channelActivation,'montage')
        title(['Channel ',num2str(channel), ' Input (left), activation (right)']);
    end
else
    %% for all channels
    if nargout == 0
        montage(mat2gray(allActivations));
    end
end


end