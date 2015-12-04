function [y] = NWM(X, Y, n, beta, x)
%Nadaraya-Waston model
    y = 0;
    s = 0;
    for i = 1:n
        s = s + (2* pi * beta ^ 2) ^ -0.5 * exp(- (1/(2 * beta ^ 2)) * (x-X(i,1))^2);
    end
    for i = 1:n
        y = y + Y(i,1) * (2* pi * beta ^ 2) ^ -0.5 * exp(- (1/(2 * beta ^ 2)) * (x-X(i,1))^2) / s;
    %    disp([X(i,1), (2* pi * beta ^ 2) ^ -0.5 * exp(- (1/(2 * beta ^ 2)) * (x-X(i,1))^2) / s]);
    end