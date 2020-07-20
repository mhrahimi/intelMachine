function [input, response, info] = readNextItem(obj)
if ~obj.hasdata % index exceed
    [input, response, info] = indexExceedOuput;
end
if ~obj.hasdata(obj.readingCache) % end of chache
    if isfield(obj.readingCache, 'head')
        obj.head = obj.head + 1; % go to next reading
    end
    obj.readingCache.head = 1; % reset cache head
    if ~obj.hasdata % index exceed
        [input, response, info] = indexExceedOuput
    else
        obj.readingCache.data = obj.fetch(obj.head); % read/fillout cache
        [~,obj.readingCache.Len] = size(obj.readingCache.data);
        obj.readingCache.head = 1; % reset head
    end
end % reading index, cachinex and reading index are checked
if obj.hasdata(obj.readingCache)
    input = obj.readingCache.data(:, obj.readingCache.head);
    response = categorical(obj.Label(obj.head), unique(obj.Label));
    info.Size = size(input);
    info.FileName = obj.File{obj.head};
    info.Label = categorical({obj.Label{obj.head}});
    info.Source = categorical({obj.Source{obj.head}});
    
    obj.readingCache.head = obj.readingCache.head + 1;
else % for empty output
    [input, response, info] = readNextItem(obj);
end
    function [input, response, info] = indexExceedOuput
        input = {[]};
        response = {[]};
        info = 'indexExceed';
        obj.head = obj.head + 1;
        return;
    end
end