d = importdata("traindata.txt");
test = importdata("testinputs.txt");
X = d(:,1:8); y = d(:,9);

N = length(X);
n_training = floor(N*.7);
n_test = N - n_training;
ids_shuffled = randperm(N);
ids_training = ids_shuffled(1:n_training);
ids_test = ids_shuffled(n_training + 1:N);

% defines the hold-out set
X_tr = X(ids_training, :); y_tr = y(ids_training, :);
X_te = X(ids_test, :);     y_te = y(ids_test, :);

max_p = 10;
results_tr = zeros(max_p + 1, 2);
results_te = zeros(max_p + 1, 2);
results_all = zeros(max_p + 1, 2);

for p=0:max_p
    poly = get_polynomial(p, ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"]);
    Z_tr = expand(poly, X_tr);
    [M R w] = least_squares(Z_tr, y_tr);
    results_tr(p+1, 1:2) = [p R];
    
    Z_te = expand(poly, X_te);
    y_te_pred = w' * Z_te;
    R_te = sum((y_te' - y_te_pred).^2);
    R_te = norm(y_te' - y_te_pred)^2;
    results_te(p+1, :) = [p R_te];
%     results_te(p+1,:) = [p  sum((y_te' - w'*Z_te).^2)];
end

global figure_number;
figure_number = 1;
plot_errors(results_tr, 'b');
figure_number = figure_number - 1;
plot_errors(results_te, 'r');

