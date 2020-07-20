function feedDispatcher(obj, refs)
multiplier = 2;
if strcmp(refs(2).type, '()')
    feed = refs(2).subs{1, 1};
elseif strcmp(refs(2).type, '.')
    switch lower(refs(2).subs)
        case "cutting"
            feed = obj.cuttingFeed;
        case "superfast"
            feed = obj.cuttingFeed * (multiplier^2);
        case "fast"
            feed = obj.cuttingFeed * multiplier;
        case "slow"
            feed = obj.cuttingFeed / multiplier;
        case "superslow"
            feed = obj.cuttingFeed / (multiplier^2);
        case "hundred"
            feed = 100;
        case "precaution"
            feed = 50;
        otherwise
            error("In 'feedDispatcher' the feed amount is not assigned due to invalid input");
    end
end
obj.F(feed);
end