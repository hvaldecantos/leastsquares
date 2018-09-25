function [X_tr, y_tr, X_te, y_te] = get_folds(X, y, fold_sizes, k)
    N = length(X);
    i_start = sum(fold_sizes(1:k-1)) + 1;
    i_end = i_start + fold_sizes(k) - 1;

    X_tr = X([1:i_start-1 i_end+1:N], :);   y_tr = y([1:i_start-1 i_end+1:N], :);
    X_te = X(i_start:i_end, :);  y_te = y(i_start:i_end, :);
end
