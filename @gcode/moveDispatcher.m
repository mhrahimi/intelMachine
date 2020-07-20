function moveDispatcher(obj, refs)
code = [];
if numel(refs) == 2 % *.move(X, Y, Z, A, B, F, comment)
    commandList = ['X', 'Y', 'Z', 'A', 'B', 'F', "comment"];
    for i = 1:numel(refs(2).subs)
        if ~isempty(refs(2).subs{i}) & ~isnan(refs(2).subs{i})
            code = [code, obj.commandDecoder(commandList(i), refs(2).subs{i})...
                , obj.driver.spc];
        end
    end
else % *.move.XYZABF(value).XYZABF(value)...
    for i = 2:2:numel(refs)
        if strcmp(refs(i).type, '.') & strcmp(refs(i+1).type, '()') % Sanity check
            code = [code, obj.commandDecoder(refs(i).subs, refs(i+1).subs{1}), obj.driver.spc];
%         elseif strcmp(refs(i).type, '.') & strcmp(refs(i+1).type, '()')
        elseif strcmp(refs(i).type, '.') & strcmp(refs(i+1).type, '.') &...
                strcmp(lower(refs(i).subs), 'f') % *.move.XYZABF(value).XYZABF(value).F.Fast
            obj.feedDispatcher(refs(i:i+1));
        else
            error("Wrong input format for 'move' command");
        end
    end
end
obj.addLine(code, 1);
end

