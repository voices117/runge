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


%-----------------------------------------------------------------------------
% using equidistant points

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
saveas(gcf, 'newton.jpg');


%-----------------------------------------------------------------------------
% using chebyshev nodes

hold off;
current_plt = 1;
legend_info = {};

% plots the runge function
plot_func(@runge, 'runge', '-');

% builds and plots newton polynomials for each degree using the Chebyshev nodes
array_points = [4 8 12 16];
for num_points = array_points
    x = chebyshev_nodes(num_points+1);
    assert(size(x) == [1 num_points+1]);

    p = newton(x, runge(x));
    plot_func(p, strcat('grado ', num2str(num_points)) );
end

% sets plot legends
legend(legend_info);
saveas(gcf, 'chebyshev.jpg');


%-----------------------------------------------------------------------------
% spline using chebyshev nodes

hold off;
current_plt = 1;
legend_info = {};

% plots the runge function
plot_func(@runge, 'runge', '-');

% builds and plots newton polynomials for each degree using the Chebyshev nodes
degrees = [4 8 12 16];
for degree = degrees
    x = chebyshev_nodes(degree+1);
    assert(size(x) == [1 degree+1]);

    p = spline(x, runge(x));
    plot_func(@(x) ppval(p, x), strcat(num2str(degree), ' puntos') );
end

% sets plot legends
legend(legend_info);
saveas(gcf, 'splines.jpg');
