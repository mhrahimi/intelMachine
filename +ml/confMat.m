function outVals = confMat(trueClass, PredClass, noLabel)

cm = confusionchart(trueClass,PredClass, 'DiagonalColor', 'green', 'Normalization' , 'total-normalized' );
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
cm.Title = 'Confusion Matrix';

if 3<=nargin && noLabel
    cm.Title = '';
    cm.XLabel = '';
    cm.YLabel = '';
end

if nargout == 1
    outVals = cm.NormalizedValues;
end

end