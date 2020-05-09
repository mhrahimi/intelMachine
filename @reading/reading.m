classdef reading < handle
    %     properties (Access = private)
    %         Len
    %     end
    properties
        % dataset attributes
        File
        No {mustBeNonnegative}
        Label
        Source
        Extention
        Len
        
        % grinder attributes
        %         FileLineCount
        %         BatchSize
        BatchInd = {};
        BatchCount
        
        
        FilteringFunction = @(x) x;
        FransformationFunction = @(x) x;
    end
    properties (Access = private)
        isGrinded = false;
        
        readingFunction = @(x) readmatrix(x, 'NumHeaderLines', 0);
        stackIterator
    end
    properties
        Properties = table();
        
        FilteringIsOn = 0;
        
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
            
            if exist(fullfile(dsPath, 'properties.mat'))
                allProperties = importdata(fullfile(dsPath, 'properties.mat'));
            elseif exist(fullfile(dsPath, 'Properties.mat'))
                allProperties = importdata(fullfile(dsPath, 'Properties.mat'));
            end
            obj.Properties = [table(no','VariableNames',"No"), allProperties(no, :)];
        end
        
%         function varargout = subsref(obj, S)
%             if 1 <= numel(S) && strcmp(S(1).type, '{}')
%                 % Looks like obj.method(args)
%                 disp(S(1).subs);
%             else
%                 [varargout{1:nargout}] = builtin('subsref', obj, S);
%             end
%         end
        
    end
end












































