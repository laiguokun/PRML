function [X] = PCA(x)
    n = size(x,2);
    xmean = mean(x')';
    X = zeros(2,n);
    S = cov(x');
    [U,D] = eig(S);
    disp(U);
    disp(D);
    if (D(1,1) > D(2,2))
        u = U(:,1);
    else
        u = U(:,2);
    end;
    u = u/norm(u);
    disp(u);
    for i = 1:n
        tmp = xmean + (x(:,i)' * u - xmean' * u) * u;
        X(:,i) = tmp;
    end;
    