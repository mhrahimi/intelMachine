function lowResPlot(x, y, options)
if nargin <= 1
    y = x;
    x = 1:length(x);
end
if nargin <=2 | ~isfield(options, 'resolution')
    options.resolution =1e5;
end
skippingStep = ceil(length(x)/options.resolution);
xMini = x(1:skippingStep:end);
yMini = y(1:skippingStep:end);
plot(xMini,yMini);
end