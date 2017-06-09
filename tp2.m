clear; clc; close all;

% list of colors for the plots
global plot_colors = [1 0 0; 0 0.6 0; 0 0 0; 0.5 0.5 1; 0.97 0.65 0; 0.52 0.53 0.34];
global current_plt = 1;
global legend_info = {};

function y = runge(x)
    y = 1 ./ (1 + x.^2);
end

function y = chebyshev_nodes(n)
    y = 1:n;

    num = (n - y + 0.5) .* pi;
    y = 5 .* cos(num ./ n);
end

function plot_func(f, label, linestyle='--')
    % plots a function `f`. Each call to this function uses a different color for the plot

    global plot_colors;
    global current_plt;
    global legend_info;

    x = -5:0.001:5;
    p = plot(x, f(x), 'Color', plot_colors(current_plt,:), 'linestyle', linestyle);
    set( p(1), 'linewidth', 3 );
    legend_info{current_plt} = label;

    current_plt++;
    hold on;
end


% plots the runge function
plot_func(@runge, 'runge', '-');

% builds and plots newton polynomials for each degree
degrees = [4 8 12 16];
for degree = degrees
    x = linspace(-5, 5, degree+1);
    assert(size(x) == [1 degree+1]);

    p = newton(x, runge(x));
    plot_func(p, strcat('grado ', num2str(degree)) );
end

% sets plot legends
legend(legend_info);

%-----------------------------------------------------------------------------


hold off;
current_plt = 1;
legend_info = {};

% plots the runge function
plot_func(@runge, 'runge', '-');

% builds and plots newton polynomials for each degree
degrees = [4 8 12 16];
for degree = degrees
    x = chebyshev_nodes(degree+1);
    assert(size(x) == [1 degree+1]);

    p = newton(x, runge(x));
    plot_func(p, strcat('grado ', num2str(degree)) );
end

% sets plot legends
legend(legend_info);
