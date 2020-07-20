function imgOut = imagePadder(imgIn, paddingType)
[height, length, width] = size(imgIn);
if isnan(paddingType)
    imgOut = imgIn;
    return
end
switch paddingType
    case -1
        layer2 = -1 * ones(height, length);
        layer3 = layer2;
    case 0
        layer2 = zeros(height, length);
        layer3 = layer2;
    case 1
        layer2 = ones(height, length);
        layer3 = layer2;
    case 2
        layer2 = imgIn;
        layer3 = layer2;
end
imgOut = cat(3, imgIn, layer2, layer3);
end