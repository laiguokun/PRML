function [W] =  LSC(X, Y, n, d)
%least squares for classification
    X = [ones(1,n);X];
    X = X';
    Y = [Y,1-Y];
    W = (X'*X)^-1*X'*Y;
    W = W(:,1)-W(:,2);