global figure_number
figure_number = 1;

% for i=1:8
%   figure(i);
%   scatter(X(:,i), y, 10, "r", "filled"); hold on;
% end

%{
X = [1;2;5]; Y = [2;7;9];
f_str = "%f * x + %f ";
expansion = {@(x) x, @(x) zeros(length(x),1) + 1};
% #f_str = "%f * sqrt(x-0.8)";
% #expansion = {@(x) sqrt(x-0.8)};
Z = expand(expansion, X)
[M R w] = least_squares(Z, Y)
% plot_powerful_ls(f_str, expansion, w, X, Y);
% sprintf(f_str,w)
f_str = sprintf(f_str, w);
f = inline(f_str);
plotdata(X,Y,f, strcat('y = ', f_str));
%}

%{
d = importdata("iq.physical.characteristics.data.txt");
X = d.data(:,2:4); Y = d.data(:,1);

% expansion = get_polynomial(2, ["brain" "height" "weight"]);
% %expansion = {{@(x) ones(length(x),1), 1}, {@(brain) brain, 1}, {@(brain) brain.^2, 1}, {@(height) height, 2}, {@(height) height.^2, 2}, {@(weight) weight, 3}, {@(weight) weight.^2, 3}};
% f_str = "%f * 1 + %f * brain.^1 + %f * brain.^2 + %f * height.^1 + %f * height.^2 + %f * weight.^1 + %f * weight.^2";

expansion = get_polynomial(1, ["brain" "height" "weight"]);
%expansion = {{@(brain) ones(length(brain),1), 1}, {@(brain) brain, 1}, {@(height) height, 2}, {@(weight) weight, 3}};
f_str = "%f * 1 + %f * brain + %f * height + %f * weight";

Z = expand(expansion, X)

[M R w] = least_squares(Z, Y); R
f = inline(sprintf(f_str,w),'brain','height','weight')
sum((f(X(:,1),X(:,2),X(:,3)) - Y).^2) % R

%plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
% %plot_powerful_ls(f_str, expansion, w, X(:,2), Y);
% %plot_powerful_ls(f_str, expansion, w, X(:,3), Y);
%}

%{
d = importdata("ex01.data.txt");
x = d(:,1); y = d(:,2);

expansion = {};
f_str = {};
degree = 10;
sss = "";
for i=0:degree
    expansion{i+1} = get_polynomial(i, ["x"]);
    sss =  sss + "%f" + sprintf(" * x.^%d",i);
    f_str{i+1} = sss;
    sss = sss + " + ";
end

for i=1:length(f_str)
  Z = expand(expansion{i}, x);
  [M R w] = least_squares(Z, y)
  plot_powerful_ls(f_str{i}, expansion{i}, w, x, y);
end
%}

%{
d = importdata("traindata.txt");
X = d(:,1:8); Y = d(:,9);
n = 1;
for i=1:8
  for j=1:8
    figure(n);
    scatter(X(:,i),X(:,j));
    title(sprintf("(%d) X%d vs X%d",n,i,j));
    n = n + 1;
  end
end
%}


d = importdata("traindata.txt");
test = importdata("testinputs.txt");
X = d(:,1:8); Y = d(:,9);

%{
Z = [X'; zeros(1,length(X))+1];
f_str = "%f * 1 + %f * x1 + %f * x2 + %f * x3 + %f * x4 + %f * x5 + %f * x6 + %f * x7 + %f * x8";
%expansion = {@(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) zeros(length(x),1) + 1};
expansion = get_polynomial(1, ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y); R
f = inline(sprintf(f_str,w),'x1','x2','x3','x4','x5','x6','x7','x8')
RR = sum((f(X(:,1),X(:,2),X(:,3),X(:,4),X(:,5),X(:,6),X(:,7),X(:,8)) - Y).^2) % R

expansion = get_polynomial(2, ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y); R

expansion = get_polynomial(3, ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y); R

expansion = get_polynomial(4, ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y); R

expansion = get_polynomial(1, ["x1"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y); R
%}

f_str = "%f + %f * x";
%expansion = {{@(x) ones(length(x),1), 1} {@(x) x, 1}};
expansion = get_polynomial(1, ["x1", "na", "na", "na", "na", "na", "na", "na"]);
Z = expand(expansion, X);
[M R w] = least_squares(Z, Y)
% plot_powerful_ls(f_str, expansion, w, X(:,1), Y);

sprintf("------------")
f_str = "%f + %f * x";
expansion = {{@(x) ones(length(x),1), 1} {@(x) x, 1}};
Z = expand(expansion, X(:,1));
[M R w] = least_squares(Z, Y)
% plot_powerful_ls(f_str, expansion, w, X(:,1), Y);

%{
f_str = "%f * (x.^2) + %f * (x) + (%f)";
expansion = {@(x) x.^2, @(x) x, @(x) 1 + zeros(length(x),1)};
Z = expand(expansion, X(:,1));
[M R w] = least_squares(Z, Y)
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
 

f_str = "%f * x.^3 + %f * x.^2 + %f * (x) + (%f)";
expansion = {@(x) x.^3, @(x) x.^2, @(x) x, @(x) 1 + zeros(length(x),1)};
Z = expand(expansion, X(:,1));
[M R w] = least_squares(Z, Y)
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);

f_str = "%f * sqrt(x-50) + %f * x.^2";
expansion = {@(x) sqrt(x-50), @(x) x.^2};
Z = expand(expansion, X(:,1));
[M R w] = least_squares(Z, Y); R
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
%}

figure_number = 1;
