function dsNew = shuffle(ds)
% dsNew = shuffle(ds) shuffles the files and the
% corresponding labels in the datastore.

% Create a copy of datastore
dsNew = ds;
dsNew.Datastore = copy(ds.Datastore);
fds = dsNew.Datastore;

% Shuffle files and corresponding labels
numObservations = dsNew.NumObservations;
idx = randperm(numObservations);
fds.Files = fds.Files(idx);
dsNew.Labels = dsNew.Labels(idx);
end