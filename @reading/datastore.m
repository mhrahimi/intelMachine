function matlabDS = datastore(obj)
matlabDS = fileDatastore(obj.File, ...
    'ReadFcn',@obj.readingFunction);

% fileDS = sequenceDatastore(obj.File, ...
%     'ReadFcn',@obj.rf);
% % readingFunction
% labelDS = fileDatastore(obj.File, ...
%     'ReadFcn',@obj.labelArray);
% 
% matlabDS = combine(fileDS, labelDS);
end