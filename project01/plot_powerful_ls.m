function plot_powerful_ls(f_str, expansion, w, x, y)
  global figure_number ;
  figure(figure_number);
  figure_number = figure_number + 1;
  
  scatter(x, y); hold on
  
  y_prediction = zeros(size(x));
  
  for k=1:length(expansion)
      f = expansion{k}{1};
      i = expansion{k}{2};
      y_prediction = y_prediction + w(k) * f(x);
  end

  f_str = sprintf(f_str, w);
  fun_str = inline(f_str);
  
  x_plots = linspace(min(x),max(x))';
%   #x_plots = x;
%   #xplotssize = size(x_plots)
  y_plots = zeros(size(x_plots));
%   #yplotssize = size(y_plots)
  for k=1:length(expansion)
      f = expansion{k}{1};
      i = expansion{k}{2};
      y_plots = y_plots + w(k) * f(x_plots);
  end

  plot(x_plots, fun_str(x_plots), 'Color', 'r');
  plot(x_plots, y_plots, 'Color', 'b');
  
%   #xorig_y_pred_fx = [x y_prediction f(x)] #
%   #xorig_y_plots_fx = [x_plots y_plots f(x_plots)] #
  
  R = sum((y_prediction - y).^2)
  Rwrong = sum((fun_str(x) - y).^2)
%   title(strcat('R = ', mat2str(R), newline, 'y = ', f_str));
  title(sprintf("R = %f\ny = %s", R, f_str));
  
  for i=1:length(x)
%     plot([x(i) x(i)], [y(i) y_prediction(i)], 'Color', 'r','--')
     plot([x(i) x(i)], [y(i) y_prediction(i)], 'r--')
    
  end

%   #[x y_prediction f(x)]
end

