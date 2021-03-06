d = importdata("traindata.txt");
test = importdata("testinputs.txt");
X = d(:,1:8); Y = d(:,9);

% expansion = get_polynomial(1, ["x1" "na" "na" "na" "na" "na" "na" "na"]);
% expansion = get_polynomial(1, ["x" "x1" "na" "na" "na" "na" "na" "na"]);
% Z = expand(expansion, X);
% [M R w] = least_squares(Z, Y)

N = length(X);
n_training = floor(N*.7);
n_test = N - n_training;
ids_shuffled = randperm(N);
ids_training = ids_shuffled(1:n_training);
ids_test = ids_shuffled(n_training + 1:N);

X_tr = X(ids_training, :); Y_tr = Y(ids_training, :);
X_te = X(ids_test, :);     Y_te = X(ids_test, :);

max_p = 15;
results = zeros(max_p + 1,3);
for p=0:max_p
    % expansion = get_polynomial(p, ["x1" "x2" "x3" "x4" "x5" "na" "x7" "x8"]);
    expansion = get_polynomial(p, ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"]);
    Z = expand(expansion, X_tr);
    [M R w] = least_squares(Z, Y_tr);
    results(p+1, 1:2) = [p R];
    
    Z_t = expand(expansion, X);
    Y_pred = w' * Z_t;
    R_t = norm(Y - Y_pred')^2;
    results(p+1, 3) = [R_t];
%     Z = expand(expansion, X_te);
%     [M R w] = least_squares(Z, Y_te);
%     results(p+1, 3) = [R];
end


scatter(results(:,1), results(:,2), '*'); hold on
scatter(results(:,1), results(:,3), '*');
for i=1:length(results)-1
    plot([results(i,1) results(i+1,1)], [results(i,2) results(i+1,2)], 'r')
    plot([results(i,1) results(i+1,1)], [results(i,3) results(i+1,3)], 'b')
end

%{
max_p = 10;
vars = ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"];
% vars = ["x1" "x2" "x3"];
all_combinations = get_combination(vars);
results = zeros((max_p + 1)*length(all_combinations), 2);
results_vars = repmat("", length(results), length(vars));

smallestR = 999999;
whenP = 0;
whenVars = repmat("", 1, length(vars));

idx = 1;
for p=0:max_p
    for v=1:length(all_combinations) 
        expansion = get_polynomial(p, all_combinations(v,:));
        Z = expand(expansion, X);
        [M R w] = least_squares(Z, Y);
        results(idx, :) = [p R];
        results_vars(idx, :) = all_combinations(v, :);
        idx = idx + 1;
        if(R < smallestR)
            smallestR = R;
            whenP = p;
            whenVars(1,:) = all_combinations(v,:)
        end
    end
end
plot(results);
%}

% smallestR = 2.6036e+04
% whenP =  10
% whenVars = "x1"    "x2"    "x3"    "x4"    "x5"    "na"    "x7"    "x8"

folds = get_fold_sizes(X, 10);

function [FoldSizes] = get_fold_sizes(X, number_of_folds)
    N = length(X);
    fold_size = floor(N / number_of_folds);
    FoldSizes = repmat(fold_size,1,number_of_folds);
    FoldSizes(1, 1:rem(N, number_of_folds)) = FoldSizes(1, 1:rem(N, number_of_folds)) + 1;
end

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

% By Paulo Abelha
%
% Returns the powerset of set S
%
% S is a cell array
% P is a cell array of cell arrays
function [ P ] = PowerSet( S )
    na = repmat(["na"], size(S));
    n = numel(S);
    x = 1:n;
    P = cell(1,2^n);
    p_ix = 2;
    for nn = 1:n
        a = combnk(x,nn);
        for j=1:size(a,1)
            P{p_ix} = S(a(j,:));
            p_ix = p_ix + 1;
        end
    end
end