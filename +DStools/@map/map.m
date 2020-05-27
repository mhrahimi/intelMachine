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
                if strcmp(S(1).type, '()') & numel(S) == 1 % map(n) - NOT SUPPORTED AT THIS POINT
%                      if strcmp(S(1).type, ':')
%                          Nos = 
                elseif strcmp(S(1).type, '.') & strcmp(S(2).type, '.') ...
                        & strcmp(S(3).type, '()') & numel(S) == 3 % map.Sensor.Label(n)
                    if isempty(S(3).subs) | strcmp(S(3).subs, ':') % No
                        [~, ~, Nos] = size(obj.LookupTable);
                        Nos = 1:Nos;
                    else
                        Nos = S(3).subs;
                    end
                    if strcmp(S(2).subs, 'all') % Label
                        [~, Labels, ~] = size(obj.LookupTable);
                        Labels = 1:Labels;
                    else
                        Labels = obj.Mapping.Label(S(2).subs);
                    end
                    if strcmp(S(1).subs, 'all') % Source
                        [Sources, ~, ~] = size(obj.LookupTable);
                        Sources = 1:Sources;
                    else
                        Sources = obj.Mapping.Source(S(1).subs);
                    end
                    
                    if isempty(S(3).subs) %map.Sensor.Label()
                        output = obj.LookupTable(Sources, Labels, Nos);
                        i = 1;
                        while i <= length(output) % remove NaN rows
                            if all(isnan(output(:,:,i)))
                                output(:,:,i) = [];
                                i = i-1;
                            end
                            i = i+1;
                        end
                        varargout{1} = squeeze(output)';
                    else
                        output = obj.LookupTable(Sources, Labels, Nos);
                        output = output(~isnan(output));
                        varargout{1} = output(:);
                    end
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