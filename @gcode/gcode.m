classdef gcode < handle
    properties
        code
        driver
        
        cuttingFeed
    end
    properties (Access = protected)
        lineIt = 1;
        
        feedrateUpdate = NaN;
        spindleSpeedUpdate = NaN;
    end
    properties (SetAccess = private)
        log
        programName
        units
        last
    end
    methods
        function obj = gcode
            
            obj.startup;
        end
        function varargout = subsref(obj, refs)
            if numel(refs) & ~isMethodOrProperty(obj, refs(1).subs)
                switch lower(refs(1).subs)
                    case 'move'
                        obj.moveDispatcher(refs);
                    case 'feed'
                        obj.feedDispatcher(refs);
                    otherwise
                        [varargout{1:nargout}] = builtin('subsref', obj, refs);
                end
            else
                [varargout{1:nargout}] = builtin('subsref', obj, refs);
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