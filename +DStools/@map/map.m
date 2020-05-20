classdef map
    properties
        LookupStruct
        LookupTable
        Mapping
    end
    methods
        function obj = map(No, Source, Label)
            [obj.LookupTable, obj.Mapping.No, obj.Mapping.Source, obj.Mapping.Label, obj.LookupStruct] = DStools.dsLookupTable(No, Source, Label);
        end
        function varargout = subsref(obj, S)
            if numel(S) & ~isMethodOrProperty(obj, S(1).subs)
                if strcmp(S(1).type, '()') & numel(S) == 1 % map(n)
                     
                end
            else
                [varargout{1:nargout}] = builtin('subsref', obj, S);
            end
        end
    end
    methods (Access = protected)
        function isMP = isMethodOrProperty(obj, value)
            isMethod = any(strcmp(methods(obj), value));
            isProperty = any(strcmp(properties(obj), value));
            isMP = isMethod | isProperty;
        end
    end
end