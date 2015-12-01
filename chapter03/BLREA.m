function [Mn, Sn, alpha, beta] = BLREA(X, Y, n, d)
%evidence approximation for blr
    alpha = 1;
    beta = 11;
    Phi = [ones(1,n)];
    for i = 1:d
        Phi = [Phi; (X.^i)'];
    end
    Phi = Phi';
    for iter = 1: 10
        Sn = alpha * eye(d + 1) + beta * Phi' * Phi;
        Sn = Sn^-1;
        Mn = beta * Sn * Phi' * Y;
        lambda = eig(beta * Phi' * Phi);
        lambda = lambda./(lambda + alpha);
        gamma = sum(lambda);
        alpha = gamma/(Mn' * Mn);
        beta = (1/(n-gamma)) * sum((Y - (Mn'*Phi')').^2);
        beta = beta^-1;
    end