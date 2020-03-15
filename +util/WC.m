function out = WC(path, extention)
% util.WC outputs WildCard character ('*').
% util.WC(path, extention) will returns 'path\*extention'.

out = '*';
if 1 <= nargin
    out = fullfile(path, out);
    if 2 <= nargin
        out = [convertStringsToChars(out), extention];
    end
end

end
