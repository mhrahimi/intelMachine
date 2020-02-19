function img = signal2img(signal, conversionFcn, paddingMode, imgLayersNum)

if nargin <=3
    imgLayersNum = 3;
    if nargin <=2
        paddingMode = 3; % deafaukt padding mode
    end
end

for i = 1:length(signal(1,:))
    img(:,:,i) = conversionFcn(signal(:,i));
end

if 0 <= paddingMode
    switch paddingMode
        case 0
            padding = zeros(size(img(:,:,1)));
        case 1
            padding = ones(size(img(:,:,1)));
        case 2
            padding = img(:,:,1);
        case 3
            padding = img(:,:,end);
        otherwise
            warning('Unspecified Padding!!');
    end
    % padding
    if length(signal(1,:))+1 <= imgLayersNum
        for i = length(signal(1,:))+1:imgLayersNum
            img(:,:,i) = padding;
        end
    end
end


end