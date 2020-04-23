classdef tool < handle
    properties
        name
        maxDepthCut double
        overalLength double
        diameter double
        numTeeth
        helixAngle 
    end
    properties (SetAccess = private)
        radius
        angles char {mustBeMember(angles,{'deg','rad'})} = 'deg'
        unit char {mustBeMember(unit,{'metric','imperial'})} = 'metric'
    end
end