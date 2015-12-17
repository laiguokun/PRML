function [Mn, Sig, alpha, beta] = RVM(X, Y, n)
    kernel = @(xn,xm) exp(-abs(xn-xm)^2);
    alpha = ones(1,n);
    beta = 11;
    Phi = [];
    for i = 1:n
        tmp = [];
        for j = 1:n
            tmp = [tmp, kernel(X(i), X(j))];
        end
        Phi = [Phi;tmp];
    end
    for iter = 1: 10
        A = diag(alpha);
        Sig = (A + beta * Phi' * Phi)^-1;
        Mn = beta * Sig * Phi' * Y;
        lambda = zeros(1,n);
        for i = 1:n
            lambda(i) = 1 - alpha(i) * Sig(i,i);
        end
        gamma = sum(lambda);
        alpha = lambda./(Mn'.^2);
        beta = (1/(n-gamma)) * sum((Y - (Mn'*Phi')').^2);
        beta = beta^-1;
    end