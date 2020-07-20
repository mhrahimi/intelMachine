classdef reading < handle & ...
        matlab.io.Datastore & ...
        matlab.io.datastore.FileWritable & ...
        matlab.io.datastore.Partitionable & ...
        matlab.io.datastore.Shuffleable 
    properties
        % dataset attributes
        File
        No {mustBeNonnegative}
        Label
        Source
        Extention
        Len
        
        Labels
        ReadSize = 1;
        ReadIndices
        % grinder attributes
        %         FileLineCount
        %         BatchSize
        BatchInd = {};
        BatchCount
        
        
        FilteringFunction = @(x) x;
        TransformationFunction = @(x) x;
        
        FilteringIsOn = 0;
        TransformationIsOn = 0;
        
        Properties = table();
        
        Map
        
        readMode = 'deafualt';
    end
    properties (Access = protected)
        isGrinded = false;
        readingFunction = @(x) readmatrix(x, 'NumHeaderLines', 0);
        head = 1;
    end
    properties (Access = private)
        readingCache
        
        debuggingIsOn = 0;
    end
    properties (Constant)
        SupportedOutputFormats = ...
            [matlab.io.datastore.ImageDatastore.SupportedOutputFormats, "dcm"];
        DefaultOutputFormat = "dcm";
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
            obj.ReadIndices = 1:obj.Len;
            if obj.Len
                obj.Map = DStools.map(obj.No, obj.Source, obj.Label);
                
                if exist(fullfile(dsPath, 'properties.mat'))
                    allProperties = importdata(fullfile(dsPath, 'properties.mat'));
                elseif exist(fullfile(dsPath, 'Properties.mat'))
                    allProperties = importdata(fullfile(dsPath, 'Properties.mat'));
                end
                try
                    obj.Properties = [table(no','VariableNames',"No"), allProperties(no, :)];
                catch
                    warning("Properties file NOT found!")
                end
                
                obj.Labels = (categorical(obj.Label))';
            end
        end
        


        
        function subds = partition(myds,n,ii) % parallerl processing support
            subds = myds;
            subds.FileSet = partition(myds.FileSet,n,ii);
            reset(subds);
        end

        function set.readMode(obj, mode)
            input = mode(1);
            response = mode(2);
            
        end
    end
    methods (Access = protected) % parallerl processing support
        function n = maxpartitions(myds)
            n = maxpartitions(myds.FileSet);
        end
        function out = isSingleReadPerFile(obj)
            out = 0;
        end
    end
    methods (Static)
        function emptyDS = new(parentDS)
            warning('off')
            emptyDS = reading();
            warning('on')
            
            emptyDS.File = [];
            emptyDS.No = [];
            emptyDS.Label = [];
            emptyDS.Source = [];
            emptyDS.Extention = [];
            emptyDS.Len = 0;
            
            emptyDS.Labels = [];
            
            emptyDS.Properties = [];

            emptyDS.BatchInd = {};
            emptyDS.BatchCount = 0;
            
            if nargin == 1
                emptyDS.readingFunction = parentDS.readingFunction;
                emptyDS.isGrinded = parentDS.isGrinded;
                emptyDS.TransformationIsOn = parentDS.TransformationIsOn;
                emptyDS.FilteringIsOn = parentDS.FilteringIsOn;
            end
        end
    end
end












































