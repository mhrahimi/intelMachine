function varargout = allEmpty

if 1 <= nargout && nargin == 0
    for i = 1:nargout
        varargout{i} = [];
    end
end

end