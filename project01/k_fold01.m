global figure_number
figure_number = 1;


d = importdata("ex01.data.txt");
X = d(:,1); y = d(:,2);

X_tr = d(1:7,1);  y_tr = d(1:7,2);
X_te = d(8:10,1); y_te = d(8:10,2);

expansion = {};
f_str = {};
degree = 6;
sss = "";
for i=0:degree
    expansion{i+1} = get_polynomial(i, ["x"]);
    sss =  sss + "%f" + sprintf(" * x.^%d",i);
    f_str{i+1} = sss;
    sss = sss + " + ";
end

%%%% Hold-out set method %%%%

results_tr = zeros(degree + 1, 2);
results_te = zeros(degree + 1, 2);
results_te2 = zeros(degree + 1, 2);
results_all = zeros(degree + 1, 2);

N = length(X);
n_training = floor(N*.7);
n_test = N - n_training;
ids_shuffled = randperm(N); % Random idex selection
ids_training = ids_shuffled(1:n_training);
ids_test = ids_shuffled(n_training + 1:N);

% ids_training = [10     2     1     8     6     3     7]
% ids_test = [4     5     9]

% ids_training = [10     2     1     9     6     4     5]
% ids_test = [8     3     7]

% ids_training = [1     2     3     4     5     6     7]
% ids_test = [8     9     10]


X_tr = d(ids_training, 1); y_tr = d(ids_training, 2);
X_te = d(ids_test, 1);     y_te = d(ids_test, 2);

for i=1:length(f_str)
  order = i-1;
  Z = expand(expansion{i}, X_tr);
  
  [M R w] = least_squares(Z, y_tr)
%   plot_powerful_ls(f_str{i}, expansion{i}, w, X_tr, y_tr);
  results_tr(i, :) = [order R];
  
  f = inline(sprintf(f_str{i},w));  
  results_te(i, :) =  [order sum((f(X_te)-y_te).^2)/length(y_te)]; % divided by M dimension????
  Z_te = expand(expansion{i}, X_te);
  results_te2(i,:) = [order  sum((y_te' - w'*Z_te).^2)];
  
  results_all(i, :) =  [order sum((f(X)-y).^2)];
end
plot_errors(results_tr, 'b');
figure_number = figure_number - 1;
plot_errors(results_te, 'r');
% figure_number = figure_number - 1;
% plot_errors(results_te2, 'y');
% figure_number = figure_number - 1;
% plot_errors(results_all, 'g');

figure_number = 1;