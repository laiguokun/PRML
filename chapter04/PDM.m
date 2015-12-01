function [W] = PDM(X, Y, n, d)
%Probabilistic Discriminative Models, liner regression and logist function
%iterative reweighted least squares
    X = [ones(1,n);X];
    Phi = X';
    W = zeros(d+1,1);
    for iter = 1:5
        y = sigmf(W' * X,[1,0])';
        R = diag(y.*(1-y));
        H = Phi' * R * Phi;
        W = H^-1 * Phi' * R * (Phi * W - R^-1*(y-Y));
    end
    