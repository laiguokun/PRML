function [W, Sn] = BLR(X, Y, n, d)
%Bayesian Logistic Regression
    X = [ones(1,n);X];
    Phi = X';
    W = zeros(d+1,1);
    alpha = 10;
    for iter = 1:10
        y = sigmf(W' * X,[1,0])';
        R = diag(y.*(1-y));
        H = alpha^-1 * eye(d+1) + Phi' * R * Phi;
        W = W - H^-1 * Phi' * (y-Y);
    end
    y = sigmf(W' * X,[1,0])';
    R = diag(y.*(1-y));
    Sn = alpha^-1*eye(d+1) + Phi' * R * Phi;
    
    