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
        function output = countEachLabel
            Label = unique(obj.Label);
            Count = count(obj.Label, Label);
            output = table(Label, Count);
        end
        
        function subds = partition(myds,n,ii) % parallerl processing support
            subds = copy(myds);
            subds.FileSet = partition(myds.FileSet,n,ii);
            reset(subds);
        end
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
        function varargout = splitEachLabel(ds, sectionRatio)
            % It is posbiliy that inctances from diffrent sources being
            % splittd to sperated into diffrent datastores
            % SHOULD NOT be used on multi sources datastore
            randomizationIsOn = 0;
            
            if 1 <= sum(sectionRatio) 
                error("'sectionRatio' must be smaller than 1.");
            end
%             sectionRatio(end+1) = 1 - sum(sectionRatio);
            
            allSources = ds.Map.Mapping.Source.keys;
            allLabels = ds.Map.Mapping.Label.keys;
            
            for i = 1:length(sectionRatio)+1 % initialize the readings
                varargout{i} = reading.new(ds);
            end
            
            for i = 1:numel(allLabels)
                eachLabel = allLabels{i};
                thisLabelElements = ds.Map.all.(eachLabel)(:);
                [thisSize, ~] = size(thisLabelElements);
                indices = 1:thisSize;
                if randomizationIsOn
                    indices = randperm(thisSize);
                end
                lastSectionEnd = 1;
                for j = 1:length(sectionRatio)
                    thisSectionSize = floor(thisSize * sectionRatio(j));
                    thisIndices = indices(lastSectionEnd:lastSectionEnd+thisSectionSize-1);
                    varargout{j} = varargout{j} + cp(ds, indices(thisIndices));
                    lastSectionEnd = lastSectionEnd+thisSectionSize;
                end
                j = j+1;
                thisIndices = indices(lastSectionEnd:end);
                varargout{j} = varargout{j} + cp(ds, indices(thisIndices));
            end
            
        end
        function subDS = cp(ds, indicies)
            warning('off')
            subDS = reading();
            warning('on')
            
            subDS.File = ds.File(indicies);
            subDS.No = ds.No(indicies);
            subDS.Label = ds.Label(indicies);
            subDS.Source = ds.Source(indicies);
            subDS.Extention = ds.Extention(indicies);
            subDS.Len = length(indicies);
            
            subDS.Labels = ds.Labels(indicies);
            
%             subDS.Properties = ds.Properties(indicies,:);
%             subDS.Properties = table();
%             for thisNo = unique(subDS.No)
%                 subDS.Properties = [subDS.Properties;...
%                     struct2table(ds.propertiesFetch(thisNo))];
%             end
            subDS.Properties = ds.Properties;
            
            subDS.FilteringIsOn = ds.FilteringIsOn;
            subDS.TransformationIsOn = ds.TransformationIsOn;
            
            subDS.BatchInd = ds.BatchInd(indicies);
            subDS.BatchCount = ds.BatchCount(indicies);
            
            subDS.isGrinded = ds.isGrinded;
            subDS.readingFunction = ds.readingFunction;
        end
        function dsout = plus(ds1, ds2)
            dsout = reading.new;
            dsout.File = [ds1.File, ds2.File];
            dsout.No = [ds1.No, ds2.No];
            dsout.Label = [ds1.Label, ds2.Label];
            dsout.Source = [ds1.Source, ds2.Source];
            dsout.Extention = [ds1.Extention, ds2.Extention];
            dsout.Len = ds1.Len + ds2.Len;
            
            dsout.Labels = [ds1.Labels; ds2.Labels];
            
            dsout.Properties = [ds1.Properties; ds2.Properties];
            
            if isMatching(ds1.FilteringIsOn, ds2.FilteringIsOn, 'FILTERING')
                dsout.FilteringIsOn = ds1.FilteringIsOn;
            end
            if isMatching(ds1.TransformationIsOn, ds2.TransformationIsOn, 'TransformationIsOn')
                dsout.TransformationIsOn = ds1.TransformationIsOn;
            end
            
            dsout.BatchInd = [ds1.BatchInd, ds2.BatchInd];
            dsout.BatchCount = [ds1.BatchCount, ds2.BatchCount];
            
            if isMatching(ds1.isGrinded, ds2.isGrinded, 'isGrinded')
                dsout.isGrinded = ds1.isGrinded;
            end
            if isequal(ds1.readingFunction, ds2.readingFunction)
                dsout.readingFunction = ds1.readingFunction;
            end
            function out = isMatching(a, b, errorMessage)
                if ~xor(a,b)
                    out = true;
                else
                    error(['Addition is not possible - readings ', errorMessage,...
                        ' propetry is inconsistant']);
                    out = false;
                end
            end
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












































