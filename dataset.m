classdef dataset
    properties
        Files {mustBeString(Str)} = ''
    end
    properties  (Access = private)
        Len {mustBeNumeric}
        
    