function plotdata(x,y,fun,lab)

%data points: x, y
%function handle: func

lw = 3; % line width
ms = 7; % marker size
fs = 20; % font size

set(gca,'FontSize',fs)
plot(x,y,'o','LineWidth',lw,'MarkerSize',ms)
xmargin = abs(min(x)*0.1 - max(x))*0.1
ymargin = abs(min(y)*0.1 - max(y))*0.1
xlim([min(x)-xmargin max(x)+xmargin])
ylim([min(y)-ymargin max(y)+ymargin])
% xlim([min(x) max(x)])
% ylim([min(y) max(y)])
xlabel('x')
ylabel('y')

if nargin >= 3
    hold on;

    % plot the function in lines (using denser data points)

    z = min(x):.01:max(x);    
    plot(z,fun(z),'k-');

    % plot the function on the data points, in forms of red dashed lines between the measured data value & the predicted function values
    
    y_pred = fun(x);
    for i=1:length(x)
        plot(x(i)*[1 1],[y(i) y_pred(i)],'r--')
    end
    hold off

    title(sprintf('R = %f',norm(y(:)-y_pred(:))^2));
end

if nargin==2
    legend('data','Location','NorthWest');
else
    legend('data',lab,'errors','Location','NorthWest');
end
legend('boxoff');