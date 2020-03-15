function [Files, No, Sources, Labels, Extention, LookupTable] = dsConstructor(no, source, label, extention, dsPath)

if nargin == 0 || util.isWildcard(no)
    no = '*';
end

if nargin <2 || util.isWildcard(source)
    source = '*';
end

if nargin<3 || util.isWildcard(label)
    label = '*';
end

% char to string:
if nargin > 1 && isa(source, 'char')
    source = convertCharsToStrings(source);
end
if nargin > 2 && isa(label, 'char')
    label = convertCharsToStrings(label);
end

if nargin <= 3
    extention = ".csv"; % deafual extention
end

if nargin <= 4
    dsPath = DStools.dsRootPath;
    if isempty(dsPath)
        dsPath = uigetdir;
    end
end

extention = unique(extention);
label = unique(label);
source = unique(source);

i = 1;

for n = no
    for s = source
        for l = label
            dsName = DStools.dsNameGen(n, s, l, extention);
            location = fullfile(dsPath, dsName);
            set(i) = location;
            
            i = i + 1;
        end
    end
end

Files = DStools.dsDir(set);
if isempty(Files)
    [No, Sources, Labels, Extention] = util.allEmpty;
else
    [No, Sources, Labels, Extention, subNo] = DStools.dsNameExtract(Files);
end
% ds.Len = length(ds.Files);
% ds.read = @(ind) readmatrix(ds.Files{ind});
% ds.pull = @dsPull;
%
%
%     function out = dsPull()
%         if ds.Len < 1
%             out = nan;
%         else
% %             out = ds.Files(ds.Len);   % output file path
%             out = ds.read(ds.Len);  % output data
%             ds.Len = ds.Len - 1
%         end
%     end

end














































