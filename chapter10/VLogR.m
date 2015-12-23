function [W, S] = VLogR(Phi, Y)
%Variational Logistic Regression
% How to predict the result is in the Chapter04
    Y = (Y + 1)/2;
    n = size(Phi,2);
    Phi = [ones(1,n);Phi];
    lambda = @(x) (sigmf(x,[1,0]) - 0.5) / (2 * x);
    d = size(Phi,1);
    epson = zeros(n,1);
    sn = eye(d);
    mn = zeros(d,1);
    for iter = 1:10
        Eww = trace(sn) + mn' * mn;
        Ealpha = d/Eww;
        for i = 1:n
            epson(i) = Phi(:,i)' * (sn + mn * mn') * Phi(:,i);
            epson(i) = epson(i) ^ 0.5;
        end
        sn = Ealpha * eye(d);
        for i = 1:n
           sn = sn + 2 * lambda(epson(i)) * Phi(:,i) * Phi(:,i)';
        end;
        sn = sn ^ -1;
        mn = zeros(d,1);
        for i = 1:n
            mn = mn + (Y(i) - 0.5) * Phi(:,i);
        end;
        mn = sn * mn;
    end;
    W = mn;
    S = sn;
end