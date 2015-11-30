function [Wml, betaml] = MLE(X, Y, n, d)
%maximum likelihood for liner regression
    Phi = [ones(1,n)];
    for i = 1:d
        Phi = [Phi; (X.^i)'];
    end
    Phi = Phi';
    Wml = (Phi' * Phi)^-1 * Phi' * Y;
    betaml = sum((Y - (Wml' * Phi')').^2)/n; 
    betaml = sqrt(1/betaml);