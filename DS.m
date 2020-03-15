classdef DS
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
    end
    properties (Access = private)
        Properties = table();
    end
    properties
        LookupTable
        LookupStruct
        Map
    end
    methods
        function obj = DS(no, source, label, extention, dsPath)
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
        
        function data = summon(obj, index, subIndex)
            if nargin == 2
                if length(index) == 1
                    data = readmatrix(obj.File{index}, 'NumHeaderLines', 0);
                else
                    for dataIt = 1:length(data)
                        data(dataIt) = {readmatrix(obj.File(index(dataIt)), 'NumHeaderLines', 0)};
                    end
                end
            elseif nargin == 3
                disp("Under construction!!");
            end
            
        end
        
        function data = fetch(obj, source, lable, number, subNumber)
            
            data = obj.sumon(obj.LookupStruct.(source).(lable)(number));
            
        end
        
        function out = find(obj, no, source, label)
            validNos = zeros(1, obj.Len);
            validSources = zeros(1, obj.Len);
            validLabels = zeros(1, obj.Len);
            
            if nargin <= 3 || util.isWildcard(label)
                validLabels = ones(1, obj.Len);
                if nargin <= 2 || util.isWildcard(source)
                    validSources = ones(1, obj.Len);
                    if nargin == 1 || util.isWildcard(no)
                        validNos = ones(1, obj.Len);
                    else
                        for noIt = 1:length(no)
                            validNos = validNos | (obj.No == no(noIt));
                        end
                    end
                else
                    for sourceIt = 1:length(source)
                        validSources = validSources | (obj.Source == source(sourceIt));
                    end
                end
            else
                for labelIt = 1:length(label)
                    validLabels = validLabels | (obj.Label == label(labelIt));
                end
            end
            
            out = validNos & validSources & validLabels;
            out = [1:obj.Len] .* out;
            out = out(out ~= 0);
        end
        
    end
end
