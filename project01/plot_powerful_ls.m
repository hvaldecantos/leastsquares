function plot_powerful_ls(f_str, expansion, w, x, y)
    global figure_number;
    figure(figure_number);
    figure_number = figure_number + 1;
  
    lw = 3; % line width
    ms = 7; % marker size
    fs = 20; % font size

    set(gca,'FontSize',fs)
    plot(x,y,'o','LineWidth',lw,'MarkerSize',ms)
    xmargin = abs(min(x)*0.1 - max(x))*0.1
    ymargin = abs(min(y)*0.1 - max(y))*0.1
    xlim([min(x)-xmargin max(x)+xmargin])
    ylim([min(y)-ymargin max(y)+ymargin])
    xlabel('x')
    ylabel('y')
 
    hold on
  
    y_prediction = zeros(size(x));
  
    for k=1:length(expansion)
        f = expansion{k}{1};
        i = expansion{k}{2};
        y_prediction = y_prediction + w(k) * f(x);
    end

    f_str = sprintf(f_str, w);
    fun_str = inline(f_str);
  
    x_plots = linspace(min(x),max(x))';
    y_plots = zeros(size(x_plots));

    for k=1:length(expansion)
        f = expansion{k}{1};
        i = expansion{k}{2};
        y_plots = y_plots + w(k) * f(x_plots);
    end

    plot(x_plots, fun_str(x_plots), 'Color', 'r');
    plot(x_plots, y_plots, 'Color', 'b');
    
    R = sum((y_prediction - y).^2)
    Rwrong = sum((fun_str(x) - y).^2)
    title(sprintf("R = %f\ny = %s", R, f_str));
  
    for i=1:length(x)
        plot([x(i) x(i)], [y(i) y_prediction(i)], 'r--')
    end
end

