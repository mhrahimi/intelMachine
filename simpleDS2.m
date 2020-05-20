classdef simpleDS2 < handle
    properties (Access = private)
        CurrentFileIndex double
        FileSet matlab.io.datastore.DsFileSet
%         FileSet
    end
    % Property to support saving, loading, and processing of
    % datastore on different file system machines or clusters.
    % In addition, define the methods get.AlternateFileSystemRoots()
    % and set.AlternateFileSystemRoots() in the methods section.
    properties(Dependent)
        AlternateFileSystemRoots
    end
    
    methods % begin methods section
        
        function myds = simpleDS2(location,altRoots)
            myds.FileSet = matlab.io.datastore.DsFileSet(location,...
                'FileExtensions','.csv', ...
                'FileSplitSize',8*1024);
            myds.CurrentFileIndex = 1;
            
%             myds.FileSet
            
            if nargin == 2
                myds.AlternateFileSystemRoots = altRoots;
            end
            
            reset(myds);
        end
        function tf = hasdata(myds)
            % Return true if more data is available.
            tf = hasfile(myds.FileSet);
        end
        function [data,info] = read(myds)
            % Read data and information about the extracted data.
            if ~hasdata(myds)
                error(sprintf(['No more data to read.\nUse the reset ',...
                    'method to reset the datastore to the start of ' ,...
                    'the data. \nBefore calling the read method, ',...
                    'check if data is available to read ',...
                    'by using the hasdata method.']))
                
            end
            
            fileInfoTbl = nextfile(myds.FileSet);
            data = MyFileReader(fileInfoTbl);
            info.Size = size(data);
            info.FileName = fileInfoTbl.FileName;
            info.Offset = fileInfoTbl.Offset;
            
            % Update CurrentFileIndex for tracking progress
            if fileInfoTbl.Offset + fileInfoTbl.SplitSize >= ...
                    fileInfoTbl.FileSize
                myds.CurrentFileIndex = myds.CurrentFileIndex + 1 ;
            end
            
            
        end
        function reset(myds)
            % Reset to the start of the data.
            reset(myds.FileSet);
            myds.CurrentFileIndex = 1;
        end
        % Before defining these methods, add the AlternateFileSystemRoots 
        % property in the properties section 
    
        % Getter for AlternateFileSystemRoots property
        function altRoots = get.AlternateFileSystemRoots(myds)
            altRoots = myds.FileSet.AlternateFileSystemRoots;
        end

        % Setter for AlternateFileSystemRoots property
        function set.AlternateFileSystemRoots(myds,altRoots)
            try
              % The DsFileSet object manages the AlternateFileSystemRoots
              % for your datastore
              myds.FileSet.AlternateFileSystemRoots = altRoots;

              % Reset the datastore
              reset(myds);  
            catch ME
              throw(ME);
            end
        end
        
    end
        methods (Hidden = true)
        function frac = progress(myds)
            % Determine percentage of data read from datastore
            if hasdata(myds) 
               frac = (myds.CurrentFileIndex-1)/...
                             myds.FileSet.NumFiles; 
            else 
              frac = 1;  
            end 
        end
        end
        methods (Access = protected)
        % If you use the DsFileSet object as a property, then 
        % you must define the copyElement method. The copyElement
        % method allows methods such as readall and preview to 
        % remain stateless
        function dscopy = copyElement(ds)
            dscopy = copyElement@matlab.mixin.Copyable(ds);
            dscopy.FileSet = copy(ds.FileSet);
        end
        end
end

function data = MyFileReader(fileInfoTbl)
% create a reader object using the FileName
reader = matlab.io.datastore.DsFileReader(fileInfoTbl.FileName);

% seek to the offset
seek(reader,fileInfoTbl.Offset,'Origin','start-of-file');
data = readmatrix(fileInfoTbl.FileName, 'NumHeaderLines', 0);
end
function data = MyFileReaderOriginal(fileInfoTbl)
% create a reader object using the FileName
reader = matlab.io.datastore.DsFileReader(fileInfoTbl.FileName);

% seek to the offset
seek(reader,fileInfoTbl.Offset,'Origin','start-of-file');

% read fileInfoTbl.SplitSize amount of data
data = read(reader,fileInfoTbl.SplitSize);
end