function [C] = GPR(X, Y, n, beta, theta0, theta1, theta2, theta3)
%Gaussian Process for regresssion
    kernel = @(xn,xm,theta0,theta1,theta2,theta3) theta0 * exp(- (theta1/2) * norm(xn-xm)^2) + theta2 + theta3 * xn' * xm;
    b = beta^2;
    C = zeros(n,n);
    for i = 1:n
        for j = 1:n
            C(i,j) = kernel(X(i), X(j), theta0, theta1, theta2, theta3);
        end
    end
    C = C + b ^ -1 * eye(n);
    
    