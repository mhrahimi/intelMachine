classdef reading < handle
    %     properties (Access = private)
    %         Len
    %     end
    properties
        File
        No {mustBeNonnegative}
        Label
        Source
        Extention
        Len
        
        Part = {};
        gNum
        
        filteringFunction = @(x) x;
    end
    properties (Access = private)
        grinded = false;
    end
    properties
        Properties = table();
        
        filteringIsOn = 0;
        
        LookupTable
        LookupStruct
        Map
    end
    methods
        %% Constructor
        function obj = reading(no, source, label, extention, dsPath)
            if nargin <= 4
                dsPath = DStools.dsRootPath;
                if nargin <= 3
                    extention = '.csv';
                    if nargin <= 2
                        label = '*';
                        if nargin <=1
                            source = '*';
                            if nargin == 0
                                no = '';
                            end
                        end
                    end
                end
            end
            [obj.File, obj.No, obj.Source, obj.Label, obj.Extention] = DStools.dsConstructor(no, source, label, extention, dsPath);
            
            obj.Len = length(obj.File);
            
            [obj.LookupTable, obj.Map.No, obj.Map.Source, obj.Map.Label, obj.LookupStruct] = DStools.dsLookupTable(obj.No, obj.Source, obj.Label);
        end
    end
end












































