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
    end
    methods (Access = private)
    end
    methods (Static)
    end
end
% obj.feedTable = obj.feedPerTooth * obj.spindleSpeed * obj.tool.numTeeth;
% obj.cuttingSpeed = pi * obj.tool.diameter * obj.spindleSpeed / 1e3;
% obj.spindleSpeed = obj.cuttingSpeed * 1e3 / (pi  * obj.tool.diameter);
% obj.feedPerTooth = obj.feedTable / (obj.spindleSpeed * obj.tool.numTeeth);
% obj.feedPerRev = obj.feedTable / obj.spindleSpeed;
