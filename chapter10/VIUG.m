function [U,S] = VIUG(X)
%variational Inference for univariate Gaussian
    gamma0 = 0;
    u0 = 0;
    a0 = 0;
    b0 = 0;
    un = 0;
    gamman = 0.1;
    Er = 0.1;
    N = size(X,2);
    meanx = sum(X,2)/N;
    for iter = 1:10
        un = (gamma0 * u0 + N * meanx)/(gamma0 + N);
        gamman = (gamma0 + N) * Er;
        Eu = un;
        Euu = Eu*Eu + gamman ^ -1;
        an = a0 + N/2;
        bn = b0;
        for i = 1:N
            bn = bn + 0.5 * X(:,i) * X(:,i);
            bn = bn - X(:,i) * Eu;
            bn = bn + 0.5 * Euu;
        end
        bn = bn + 0.5 * gamma0 * (Eu * Eu - 2 * u0 * Eu + u0 * u0);
        Er = an/bn;
    end
    U = Eu;
    S = gamman ^ -1;