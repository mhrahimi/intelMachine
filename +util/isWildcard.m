function out = isWildcard(input)

out = false;
if isequal(input, "all") || isequal(input, '*') || (isnumeric(input) && all(input == -1)) || isequal(input, Inf) || isequal(input, '')
    out = true;
end
% if ~istable(input) && isinf(all(input))
%     out = input;
% end

end