d = importdata("traindata.txt");
Test = importdata("testinputs.txt");
X = d(:,1:8); y = d(:,9);

variables = ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"];
all_combinations = get_combination(variables);

N = length(X);
K = 10;
fold_sizes = get_fold_sizes(X, K);

max_p = 10;
results_tr = zeros((max_p + 1)*length(all_combinations), 2);
results_te = zeros((max_p + 1)*length(all_combinations), 2);
ws = {};
vars = {};

idx = 1;


for v=1:length(all_combinations)
    for p=0:max_p
        variables = all_combinations(v,:);
        
        poly = get_polynomial(p, variables);

        train_error_acc = 0;
        test_error_acc = 0;

        for k=1:K
            i_start = sum(fold_sizes(1:k-1)) + 1;
            i_end = i_start + fold_sizes(k) - 1;

            X_tr = X([1:i_start-1 i_end+1:N], :);   y_tr = y([1:i_start-1 i_end+1:N], :);
            X_te = X(i_start:i_end, :);  y_te = y(i_start:i_end, :);

            Z_tr = expand(poly, X_tr);
            [M, R_tr, w] = least_squares(Z_tr, y_tr);
            train_error_acc = train_error_acc + R_tr; % SSE

            Z_te = expand(poly, X_te);
            test_error_acc = test_error_acc + sum((y_te' - w'*Z_te).^2); % SSE
        end
        results_tr(idx, :) = [p train_error_acc/K]; % mean of SSEs
        results_te(idx, :) = [p test_error_acc/K];  % mean of SSEs
        ws{idx} = w;
        vars{idx} = variables;
        idx = idx + 1;
    end
end

% Find the predicted values
[min_test_err, min_test_err_idx] = min(results_te);
min_test_err_idx = min_test_err_idx(2);
min_test_err = min_test_err(2);
min_test_err_order = results_te(min_test_err_idx, 1);

fold_start = min_test_err_idx - rem(min_test_err_idx - 1, max_p + 1);
fold_end = fold_start + max_p;

plot_errors(results_tr(fold_start:fold_end, :), 'b');
hold on;
plot_errors(results_te(fold_start:fold_end, :), 'r');

variables = vars{min_test_err_idx};
poly = get_polynomial(min_test_err_order, variables);
sprintf("Features selected: [%s]",join(variables))

sprintf("Polynomial order: %d\nMin test error  : %f", min_test_err_order, min_test_err/(N/K)) % MSE

Z = expand(poly, X);
y_pred = ws{min_test_err_idx}' * Z;
training_error = sum((y - y_pred').^2)/N; % MSE
sprintf("Polynomial order: %d\nTraining error  : %f", min_test_err_order, training_error)

Z = expand(poly, Test);
y_pred = ws{min_test_err_idx}' * Z;
dlmwrite('predicted_values.txt', num2str(y_pred','%.7e\t'),'delimiter', '');

function [A] = get_combination(vars)
    n = numel(vars);
    max = (2^n)-1;
    pad_size = length(dec2bin(max));
    A = repmat("",max,n);
    for i=1:max
        comb = pad(dec2bin(i),pad_size,'left','0');
        for j=1:n
            if(comb(j) == '1')
                A(i,j) = vars(1,j);
            else
                A(i,j) = "na";
            end
        end
    end
end
