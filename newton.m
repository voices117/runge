function p = newton(x, y)
    % Interpolates a function using the Newton's polynomial.
    % Receives a set of points `x` and it's images (i.e. f(x)) `y`.
    % Returns the resulting polynomial as a function handle `p`.

    subp = reduce(x, y, 1);
    p = @(n) y(1) + subp(n);
end

function p = reduce(x, dfs, current_step)
    n = size(dfs)(2) - 1;

    % calculates the new coefficients from the previous ones
    differencies = zeros(1, n);
    for i = 1:n
        coef = dfs(1, i+1) - dfs(1, i);
        differencies(1, i) = coef / (x(i+current_step) - x(i));
    end

    % cut condition
    if size(differencies)(2) == 1
        p = @(n) differencies(1) * polynomial(n, x(1:end-1));
    else
        % recursive call to get the next term
        subp = reduce(x, differencies, current_step + 1);
        p = @(n) differencies(1) * polynomial(n, x(1:current_step)) + subp(n);
    end
end

function y = polynomial(x, points)
    % Given a value `x` and a set of `points`, returns (x - p_1) * (x - p_2) * ... * (x - p_n)

    y = 1;
    for i = 1:size(points)(2)
        y *= x - points(i);
    end
end
