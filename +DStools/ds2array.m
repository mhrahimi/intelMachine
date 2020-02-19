function multiLayerSignal = ds2array(dsRead, dsInd, reqLength, paddingMode)
% ds2array apply the given function (as dsRead) to the indices of the ds in
% dsInd.
%  multiLayerSignal = ds2array(dsRead, dsInd)
%  Reads the dsInd indices from DS using dsRead function and store it in a 2D array named multiLayerSignal.
%  multiLayerSignal = ds2array(dsRead, dsInd, reqLength, paddingMode) Will
%  add padding based on paddingMode to make the out as big as reqLength
%

for i = 1:length(dsInd)
    multiLayerSignal(:,i) = dsRead(dsInd(i));
end

if 4 <= nargin
    switch paddingMode
        case 0
            padding = zeros(length(multiLayerSignal(:,1)),1);
        case 1
            padding = ones(length(multiLayerSignal(:,1)),1);
        case 2
            padding = multiLayerSignal(:,1);
        case 3
            padding = multiLayerSignal(:,end);
        otherwise
            warning('Unspecified Padding!!');
    end
    
    for i = length(dsInd)+1:reqLength
        multiLayerSignal(:,i)=  padding;
    end
        
end

end