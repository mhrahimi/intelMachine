function out = kernel(kernelName, size, mag)

kernel.hLine = @(size,mag) hLine(size,mag);
kernel.vLine = @(size,mag) vLine(size, mag);
kernel.oblique45 = @(size,mag) oblique45(size, mag);
kernel.oblique135 = @(size,mag) oblique135(size, mag);
kernel.edge = @(size,mag) edge(size, mag);


switch lower(kernelName)
    case 'hline'
        out = kernel.hLine(size, mag);
    case 'vline'
        out = kernel.vLine(size, mag);
    case 'oblique45'
        out = kernel.oblique45(size, mag);
    case 'oblique135'
        out = kernel.oblique135(size, mag);
    case 'edge'
        out = kernel.edge(size,mag);
        
end

end

function out = hLine(size,mag)

out = ones(size)*-1*mag;
if rem(size,2) == 1
    out(ceil(size/2), :) = ones(size,1)*(size-1)*mag;
end
end


function out = vLine(size,mag)

out = ones(size)*-1*mag;
if rem(size,2) == 1
    out(:, ceil(size/2)) = ones(size,1)*(size-1)*mag;
end
end

function out =  oblique45(size, mag)

out = ones(size)*-1*mag;
if rem(size,2) == 1
    out = eye(size)*(size-1)*mag + ~eye(size).*out;
end

end

function out =  oblique135(size, mag)

out = ones(size)*-1*mag;
if rem(size,2) == 1
    out = (eye(size)')*(size-1)*mag + (~eye(size))'.*out;
end

end

function out =  edge(size, mag)

out = ones(size)*-1*mag;
if rem(size,2) == 1
    out(ceil(size/2),ceil(size/2)) = (size^2-1)*mag;
end

end

function out = LoG(size, mag)
sigma = 1;
for i = 1:size
    for j = 1:size
        out(i,j) = (-1/(pi*sigma^4))*(1-(x^2+y^2)/2*(sigma^2))*exp(-(x^2+y^2)/(2*sigma^2));
    end
end
end

