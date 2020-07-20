function code = F(obj, f)
code = ['F' num2str(f)];
obj.last.F = f;
feedrateUpdate = NaN;
if nargout == 0
    obj.feedrateUpdate = f;
end
end