function [m1, m2, S] = PGM(X, Y, n, d)
%Fisher linear discriminant
    X = X';
    X1 = X(Y(:,1) == 1, :);
    X2 = X(Y(:,1) == 0, :);
    n1 = size(X1,1);
    n2 = size(X2,1);
    m1 = mean(X1)';
    m2 = mean(X2)';
    v1 = (X1' - repmat(m1,1,n1));
    v2 = (X2' - repmat(m2,1,n2));
    v1 = v1 * v1' / n1;
    v2 = v2 * v2' / n2;
    S = v1*n1/n + v2*n2/n;
    