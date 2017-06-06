% builds the newton polynomial for the Runge function

function y = runge(x)
    y = 1 ./ (1 + x.^2);
end


function plot_func(f)
    x = -5:0.1:5;
    plot(x, f(x));
end


% plots the runge function
plot_func(runge);

% 4th grade polynomial
x = -5:10/4:5;
p4 = newton(x, runge(x));
plot_func(p4);

% 8th grade polynomial
x = -5:10/7:5;
p8 = newton(x, runge(x));
plot_func(p8);

% 12th grade polynomial
x = -5:10/11:5;
p12 = newton(x, runge(x));
plot_func(p12);

% 16th grade polynomial
x = -5:10/15:5;
p16 = newton(x, runge(x));
plot_func(p16);
