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
[M R w] = powerful_least_squares(Z, Y)
% plot_powerful_ls(f_str, expansion, w, X, Y);
% sprintf(f_str,w)
f_str = sprintf(f_str, w);
f = inline(f_str);
plotdata(X,Y,f, strcat('y = ', f_str));
%}

%{
d = importdata("iq.physical.characteristics.data.txt");
X = d.data(:,2:4); Y = d.data(:,1);

f_str = "%f * 1 + %f * x + %f * y + %f * z";
f_str = "%f * x.^2 + %f * x + %f * y.^2 + %f * y + %f * z.^2 + %f * z + %f * 1";
expansion = {{@(x) ones(length(x),1), 1}, {@(x) x, 1}, {@(y) y, 2}, {@(z) z, 3}};
expansion = {{@(x) x.^2, 1}, {@(x) x, 1}, {@(y) y.^2, 2}, {@(y) y, 2}, {@(z) z.^2, 3}, {@(z) z, 3}, {@(x) ones(length(x),1), 1}};

Z = expand(expansion, X);
[M R w] = powerful_least_squares(Z, Y); R
f = inline(sprintf(f_str,w),'x','y','z')
sum((f(X(:,1),X(:,2),X(:,3)) - Y).^2) % R
%plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
% %plot_powerful_ls(f_str, expansion, w, X(:,2), Y);
% %plot_powerful_ls(f_str, expansion, w, X(:,3), Y);
%}


d = importdata("ex01.data.txt");
x = d(:,1); y = d(:,2);
f_str = {"%f * x.^0"
         "%f * x.^0 + %f * x.^1"
         "%f * x.^0 + %f * x.^1 + %f * x.^2"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5 + %f * x.^6"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5 + %f * x.^6 + %f * x.^7"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5 + %f * x.^6 + %f * x.^7 + %f * x.^8"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5 + %f * x.^6 + %f * x.^7 + %f * x.^8 + %f * x.^9"
         "%f * x.^0 + %f * x.^1 + %f * x.^2 + %f * x.^3 + %f * x.^4 + %f * x.^5 + %f * x.^6 + %f * x.^7 + %f * x.^8 + %f * x.^9 + %f * x.^10"};

expansion = {}
for i=0:10
    expansion{i+1} = get_polynomio(i);
end

for i=1:length(f_str)
  Z = expand(expansion{i}, x);
  [M R w] = powerful_least_squares(Z, y)
  plot_powerful_ls(f_str{i}, expansion{i}, w, x, y);
end


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

%{
d = importdata("traindata.txt");
test = importdata("testinputs.txt");
X = d(:,1:8); Y = d(:,9);
Z = [X'; zeros(1,length(X))+1];
f_str = "%f * x1 + %f * x2 + %f * x3 + %f * x4 + %f * x5 + %f * x6 + %f * x7 + %f * x8 + %f * 1";
expansion = {@(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) x, @(x) zeros(length(x),1) + 1};
%Z = expand(expansion, X);
[M R w] = powerful_least_squares(Z, Y); R
f = inline(sprintf(f_str,w),'x1','x2','x3','x4','x5','x6','x7','x8')
RR = sum((f(X(:,1),X(:,2),X(:,3),X(:,4),X(:,5),X(:,6),X(:,7),X(:,8)) - Y).^2) % R



%f_str = "%f * x + %f";
%expansion = {@(x) x, @(x) zeros(length(x),1) + 1};
f_str = "%f * x + %f";
expansion = {@(x) x, @(x) zeros(length(x),1) + 1};
Z = expand(expansion, X(:,1));
[M R w] = powerful_least_squares(Z, Y)
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);

f_str = "%f * (x.^2) + %f * (x) + (%f)";
expansion = {@(x) x.^2, @(x) x, @(x) 1 + zeros(length(x),1)};
Z = expand(expansion, X(:,1));
[M R w] = powerful_least_squares(Z, Y)
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
 

f_str = "%f * x.^3 + %f * x.^2 + %f * (x) + (%f)";
expansion = {@(x) x.^3, @(x) x.^2, @(x) x, @(x) 1 + zeros(length(x),1)};
Z = expand(expansion, X(:,1));
[M R w] = powerful_least_squares(Z, Y)
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);

f_str = "%f * sqrt(x-50) + %f * x.^2";
expansion = {@(x) sqrt(x-50), @(x) x.^2};
Z = expand(expansion, X(:,1));
[M R w] = powerful_least_squares(Z, Y); R
plot_powerful_ls(f_str, expansion, w, X(:,1), Y);
%}

figure_number = 1;

function [A b] = triangularize(A, b)
  [Ma Na] = size(A);
  [Mb Nb] = size(b);

  for i=1:Ma
    for j=i+1:Ma
      c = -A(j,i)/A(i,i);
      for k=1:Na
        A(j,k) = A(j,k) + c * A(i,k);
      end
      b(j,1) = b(j,1) + c * b(i,1);
    end
  end  
end

function x = back_substitute(A, b)
  [Ma Na] = size(A);
  [Mb Nb] = size(b);

  if(Na ~= Mb)
      error("cannot multiply matrices")
  end

  x = zeros(Mb, Nb);

  for i = Na:-1:1
    c = b(i);
    for j=i+1:Na
      c = c - A(i,j)*x(j);
    end
    x(i) = c/A(i,i);
  end
   
%   for i = Ma:-1:1
%     x(i) = (b(i) - A(i,i+1:Na)*x(i+1:Na))/A(i,i);
%   end
  
end

function [M R w] = powerful_least_squares(Z, y)
  [p N] = size(Z);

  M = zeros(size(Z,1));
  s = zeros(size(Z,1),1);

  M = Z*Z';
  s = Z*y;

  [Ap bp] = triangularize(M,s);
  w = back_substitute(Ap,bp);

  y_pred = w' * Z;
  R = norm(y - y_pred')^2;
end

%{
function plot_powerful_ls(f_str, expansion, w, x, y)
  global figure_number ;
  figure(figure_number);
  figure_number = figure_number + 1;
  
  scatter(x, y); hold on
  
  y_prediction = zeros(length(x),1);
  
  for k=1:length(expansion)
    y_prediction = y_prediction + w(k)*expansion{k}(x);
  end

  f_str = sprintf(f_str, w);
  f = inline(f_str);
  x_plots = linspace(min(x),max(x))';
%   #x_plots = x;
%   #xplotssize = size(x_plots)
  y_plots = zeros(length(x_plots),1);
%   #yplotssize = size(y_plots)
  for k=1:length(expansion)
    y_plots = y_plots + w(k) .* expansion{k}(x_plots);
  end

  plot(x_plots, f(x_plots), 'Color', 'r');
  plot(x_plots, y_plots, 'Color', 'b');
  
%   #xorig_y_pred_fx = [x y_prediction f(x)] #
%   #xorig_y_plots_fx = [x_plots y_plots f(x_plots)] #
  
  R = sum((y_prediction - y).^2)
  Rwrong = sum((f(x) - y).^2)
%   title(strcat('R = ', mat2str(R), newline, 'y = ', f_str));
  title(sprintf("R = %f\ny = %s", R, f_str));
  
  for i=1:length(x)
%     plot([x(i) x(i)], [y(i) y_prediction(i)], 'Color', 'r','--')
     plot([x(i) x(i)], [y(i) y_prediction(i)], 'r--')
    
  end

%   #[x y_prediction f(x)]
end
%}
