classdef cut < handle
    properties
        spindleSpeed % n - rpm
        cuttingSpeed % v_c - m/min​
        
        feedPerRev % feed per rev - mm/rev
        feedPerTooth % f_z - mm/tooth
        feedTable % v_f - mm/min (cutting feed)
        
        depthCutRadial % a_e - mm
        depthCutAxial % a_p - mm
%         unit type {mustBeMember(unit,{'face','shoulder','profile',,'slot'})} = 'slot'
        
%         tool
        numTeeth {mustBeInteger}
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
% obj.feedTable = obj.feedPerTooth * obj.numTeeth * obj.spindleSpeed;
% power = obj.depthCutAxial * obj.depthCutRadial * obj.feedTable *
% specificCuttingForce / (60*1e6); % P_c - kW
% torque = obj.power * 30 * 1e3 / (pi/obj.spindleSpeed); % M_c - Nm
% obj.materialRemovalRate = depthCutRadial * depthCutAxial * feedTable /
% 1e3;
