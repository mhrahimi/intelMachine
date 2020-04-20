classdef cut < handle
    properties
        spindleSpeed % rpm
        cuttingSpeed % m/min​
        
        feedPerRev % feed per rev
        feedPerTooth % mm
        feedTable % mm/min (cutting feed)
        
        depthCut
        
        tool
    end
    properties (SetAccess = private)
        unit char {mustBeMember(unit,{'metric','imperial'})} = 'metric'
    end
    methods
        %                 obj.feedTable = obj.feedPerTooth * obj.spindleSpeed * obj.tool.numTeeth;
        %                 obj.cuttingSpeed = pi * obj.tool.diameter * obj.spindleSpeed / 1e3;
        %                 obj.spindleSpeed = obj.cuttingSpeed * 1e3 / (pi  * obj.tool.diameter);
        %                 obj.feedPerTooth = obj.feedTable / (obj.spindleSpeed * obj.tool.numTeeth);
        %                 obj.feedPerRev = obj.feedTable / obj.spindleSpeed ;

        function set.spindleSpeed(obj, v)
            obj.spindleSpeed = v;
            obj.update;
        end
        function set.cuttingSpeed(obj, v)
            obj.cuttingSpeed = v;
            obj.update;
        end

        function set.feedPerRev(obj, v)
            obj.feedPerRev = v;
            obj.update;
        end
        function set.feedPerTooth(obj, v)
            obj.feedPerTooth = v;
            obj.update;
        end
        function set.feedTable(obj, v)
            obj.feedTable = v;
            obj.update;
        end
        
        function set.depthCut(obj, v)
            obj.depthCut = v;
            obj.update;
        end
        
        function set.tool(obj, v)
            obj.tool = v;
            obj.update;
        end
    end
    methods (Access = private)
        function update(obj)
            try
                obj.feedTable = obj.feedPerTooth * obj.spindleSpeed * obj.tool.numTeeth;
            catch err
            end
            try
                obj.cuttingSpeed = pi * obj.tool.diameter * obj.spindleSpeed / 1e3;
            catch err
            end
            try
                obj.spindleSpeed = obj.cuttingSpeed * 1e3 / (pi  * obj.tool.diameter);
            catch err
            end
            try
                obj.feedPerTooth = obj.feedTable / (obj.spindleSpeed * obj.tool.numTeeth);
            catch err
            end
            try
                obj.feedPerRev = obj.feedTable / obj.spindleSpeed ;
            catch err
            end
        end
    end
end
