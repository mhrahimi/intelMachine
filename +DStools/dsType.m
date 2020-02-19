function dsTypeOut = dsType(ds)

dsTypeOut = 0; % not a ds
if isstruct(ds)
    if isfield(ds, 'Parts')
        dsTypeOut = 3; % is a ds
    elseif isfield(ds, 'Properties')
        dsTypeOut = 2; % is a properties added ds
    elseif isfield(ds, 'Files')
        dsTypeOut = 1; % is a grinded ds
    end
end

end
