function [X] = whitening(x)
    [d,n] = size(x);
    S = cov(x');
    [U,L] = eig(S);
    xmean = mean(x')';
    X = zeros(d,n);
    tmp = 0;
    for i = 1:n
        X(:,i) = L^(-0.5) * U' * (x(:,i) - xmean);
    end