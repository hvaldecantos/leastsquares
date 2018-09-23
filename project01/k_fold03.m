d = importdata("traindata.txt");
Test = importdata("testinputs.txt");
X = d(:,1:8); y = d(:,9);

N = length(X);
K = 10;
fold_sizes = get_fold_sizes(X, K);

max_p = 9;
results_tr = zeros(max_p + 1, 2);
results_te = zeros(max_p + 1, 2);
ws = {};

for p=0:max_p
    poly = get_polynomial(p, ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"]);
    
    train_error_acc = 0;
    test_error_acc = 0;
    
    for k=1:K
        i_start = sum(fold_sizes(1:k-1)) + 1;
        i_end = i_start + fold_sizes(k) - 1;

        X_tr = X([1:i_start-1 i_end+1:N], :);   y_tr = y([1:i_start-1 i_end+1:N], :);
        X_te = X(i_start:i_end, :);  y_te = y(i_start:i_end, :);
        
        Z_tr = expand(poly, X_tr);
        [M R_tr w] = least_squares(Z_tr, y_tr);
        train_error_acc = train_error_acc + R_tr;

        Z_te = expand(poly, X_te);
        test_error_acc = test_error_acc + sum((y_te' - w'*Z_te).^2);
    end
    results_tr(p+1, :) = [p train_error_acc/K];
    results_te(p+1, :) = [p test_error_acc/K];
    ws{p+1} = w;
end

global figure_number;
figure_number = 1;
plot_errors(results_tr, 'b');
figure_number = figure_number - 1;
plot_errors(results_te, 'r');

% Find the predicted values
[min_err min_idx] = min(results_te);

p = results_te(min_idx(1, 2), 1);
poly = get_polynomial(p, ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"]);
Z = expand(poly, Test);
y_pred = ws{p+1}' * Z;
dlmwrite('predicted_values.txt', num2str(y_pred','%.7e\t'),'delimiter', '');
% dlmwrite('test_values_and_predicted_values.txt', num2str([Test y_pred'],'%.7e\t'),'delimiter', '');

function [FoldSizes] = get_fold_sizes(X, number_of_folds)
    N = length(X);
    fold_size = floor(N / number_of_folds);
    FoldSizes = repmat(fold_size,1,number_of_folds);
    FoldSizes(1, 1:rem(N, number_of_folds)) = FoldSizes(1, 1:rem(N, number_of_folds)) + 1;
end