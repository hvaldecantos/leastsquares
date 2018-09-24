function [FoldSizes] = get_fold_sizes(X, number_of_folds)
    N = length(X);
    fold_size = floor(N / number_of_folds);
    FoldSizes = repmat(fold_size,1,number_of_folds);
    FoldSizes(1, 1:rem(N, number_of_folds)) = FoldSizes(1, 1:rem(N, number_of_folds)) + 1;
end