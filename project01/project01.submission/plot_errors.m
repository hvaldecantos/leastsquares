function [] = plot_errors(results, color)
    % reults input argument is a Mx2 matrix:
    % col 1: polynomial orders
    % col 2: R
    scatter(results(:,1), results(:,2), '*', color); hold on
    for i=1:length(results)-1
        plot([results(i,1) results(i+1,1)], [results(i,2) results(i+1,2)], color)
    end
end
