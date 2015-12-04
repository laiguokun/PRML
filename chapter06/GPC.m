function [an] = GPC(X, Y, n, theta0, theta1, theta2, theta3)
%Gaussian Process for regresssion
    beta = 10;
    b = beta ^ -2;
    kernel = @(xn,xm,theta0,theta1,theta2,theta3) theta0 * exp(- (theta1/2) * norm(xn-xm)^2) + theta2 + theta3 * xn' * xm;
    C = zeros(n,n);
    for i = 1:n
        for j = 1:n
            C(i,j) = kernel(X(:,i), X(:,j), theta0, theta1, theta2, theta3);
        end
    end
    C = C + b ^ -1 * eye(n);
    Cc = C^-1;
    an = zeros(n,1);
    for i = 1:10
        Sn = sigmf(an, [1,0]);
        Wn = diag(Sn .* (1 - Sn));
        an = C * (eye(n) + Wn * C)^-1 *(Y - Sn + Wn * an); 
    end;
   