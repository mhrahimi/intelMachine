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