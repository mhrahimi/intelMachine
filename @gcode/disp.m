function formatedCode = disp(obj)
formatedCode = [];
for i = 1:length(obj.code)
    formatedCode = [formatedCode, num2str(i-1), obj.driver.spc, ...
        obj.code{i}, newline];
end
if nargout == 0
    disp(formatedCode);
end
end