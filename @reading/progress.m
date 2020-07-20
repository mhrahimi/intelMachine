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
% if nargin == 

frac = 1 - (obj.Len - obj.head)/obj.Len;
end