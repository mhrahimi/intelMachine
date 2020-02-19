function err = netErr(realLabels, predictedLables)

err = nnz(predictedLables == realLabels)/numel(realLabels);

end