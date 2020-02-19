function dsOut = dsPropertiesAdder(ds)
dsOut = ds;

load(DStools.minPropertiesPath);
% nos = unique(ds.No);
% 
% t = struct2table(minProperties);
% for i = 1:height(t)
%     if ~any(i==nos)
%         t(i,:) = [];
%     end
% end
dsOut.Properties = minProperties;

dsOut.series = @(n) dsOut.Properties(dsOut.No(n)).series;
dsOut.sampling = @(n) dsOut.Properties(dsOut.No(n)).sampling;
dsOut.diameter = @(n) dsOut.Properties(dsOut.No(n)).diameter;
dsOut.numFlutes = @(n) dsOut.Properties(dsOut.No(n)).numFlutes;
dsOut.F = @(n) dsOut.Properties(dsOut.No(n)).F;
dsOut.S = @(n) dsOut.Properties(dsOut.No(n)).S;
dsOut.a = @(n) dsOut.Properties(dsOut.No(n)).a;



end
