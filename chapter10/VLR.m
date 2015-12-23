function [W] = VLR(Phi,Y)
%Variational Linear Regression
    n = size(Phi,2);
    d = size(Phi,1);
    beta = 10;
    a0 = 0;
    b0 = 0;
   
    sn = eye(d);
    mn = zeros(d,1);
    for iter = 1:1000
        Ealpha = (d/(mn' * mn + trace(sn)));
        Ebeta = n/(norm(Y - (Phi' * mn)) + trace(Phi * Phi' * sn));
        
        sn = (Ealpha * eye(d) + Ebeta * Phi * Phi') ^ -1;
        mn = Ebeta * sn * Phi * Y;
    end;
    W = mn;
        