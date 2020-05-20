classdef reading < handle & ...
        matlab.io.Datastore & ...
        matlab.io.datastore.FileWritable
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
        % grinder attributes
        %         FileLineCount
        %         BatchSize
        BatchInd = {};
        BatchCount
        
        
        FilteringFunction = @(x) x;
        TransformationFunction = @(x) x;
        
        Properties = table();
        
        FilteringIsOn = 0;
        TransformationIsOn = 0;
        
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
            %         obj.Labels = [];
        end
        
        % Matlab ds compatibility
        function reset(obj)
            obj.head = 1;
        end
        function output = hasdata(obj, input)
            if nargin == 1
                if obj.head <= obj.Len
                    output = true;
                else
                    output = false;
                end
                if obj.debuggingIsOn
                    disp(obj.head);
                end
            elseif nargin == 2
                if ~isempty(input) & input.head <= input.Len
                    output = true;
                else
                    output = false;
                end
                if obj.debuggingIsOn
                    disp(input.head);
                end
            end
        end
        function [data, info] = read(obj, varargin)
            [input, response] = obj.readNextItem;
            data(1,1) = input;
            data(1,2) = response;
            
            info.Label = response;
            
        end
        function data = readall(obj)
            data = cell(obj.Len, 1);
            i = 1;
            for i = 1:obj.Len
                data(i,1) = obj.fetch(i);
            end
        end
        function output = countEachLabel
            Label = unique(obj.Label);
            Count = count(obj.Label, Label);
            output = table(Label, Count);
        end
        
        %         function subds = partition(myds,n,ii) % parallerl processing support
        %             subds = copy(myds);
        %             subds.FileSet = partition(myds.FileSet,n,ii);
        %             reset(subds);
        %         end
        function frac = progress(obj)
            %PROGRESS   Percentage of consumed data between 0.0 and 1.0.
            %   Return fraction between 0.0 and 1.0 indicating progress as a
            %   double. The provided example implementation returns the
            %   ratio of the index of the current file from FileSet
            %   to the number of files in FileSet. A simpler
            %   implementation can be used here that returns a 1.0 when all
            %   the data has been read from the datastore, and 0.0
            %   otherwise.
            %
            %   See also matlab.io.Datastore, read, hasdata, reset, readall,
            %   preview.
            frac = (obj.Len - obj.head)/obj.Len;
        end
        function set.readMode(obj, mode)
            input = mode(1);
            response = mode(2);
            
        end
    end
    methods (Access = protected) % parallerl processing support
        %         function n = maxpartitions(myds)
        %             n = maxpartitions(myds.FileSet);
        %         end
        %         function out = isSingleReadPerFile(obj)
        %             out = 0;
        %         end
        
        function [input, response, info] = readNextItem(obj)
            if ~obj.hasdata % index exceed
                input = {[]};
                response = {[]};
                info = 'indexExceed';
                obj.head = obj.head + 1;
                return;
            end
            if ~obj.hasdata(obj.readingCache) % end of chache
                if isfield(obj.readingCache, 'head')
                    obj.head = obj.head + 1; % go to next reading
                end
                obj.readingCache.head = 1; % reset cache head
                if ~obj.hasdata % index exceed
                    input = {[]};
                    response = {[]};
                    info = 'indexExceed';
                    return;
                else
                    obj.readingCache.data = obj.fetch(obj.head);
                    [~,obj.readingCache.Len] = size(obj.readingCache.data);
                end
            end % reading index, cachinex and reading index are checked
            
            input = {obj.readingCache.data(:, obj.readingCache.head)};
            response = {categorical(obj.Label(obj.head), unique(obj.Label))};
            info.Size = size(input);
            info.FileName = obj.File{obj.head};
            info.Label = categorical({obj.Label{obj.head}});
            info.Source = categorical({obj.Source{obj.head}});
            
            obj.readingCache.head = obj.readingCache.head + 1;
        end

    end
end












































