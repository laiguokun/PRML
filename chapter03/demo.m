clear on;
d = 3;
n = 50;
alpha = 0.1;
W = normrnd(0, sqrt(alpha^-1), [d+1,1]);
beta = 10;
[X, Y] = getdata(W, n, d, beta);
plot(X, Y, 'o', 'MarkerFaceColor', 'g');
hold on;

x = 0:0.01:1;
l = size(x,2);

%liner regression
% Phi = [ones(1,l)];
% for i = 1:d
%     Phi = [Phi; (x.^i)];
% end
% [Wml, betaml] = MLE(X, Y, n, d);
% y = (Wml' * Phi);
% plot(x, y, 'r');

%bayesian linear regression
% [Mn, Sn] =  BLR(X, Y, n, d, alpha, beta);
% y = [];
% for i = 1:l
%     Phix = [];
%     for j = 1:d+1
%         Phix = [Phix;x(i)^(j-1)];
%     end
% %    y = [y, normrnd(Mn'*Phix, beta^-1+Phix'*Sn*Phix)];
%     y = [y, Mn'*Phix];
% end
% plot(x,y,'r');

%bayesian linear regression with evidence approximation
[Mn, Sn, alphablr, betablr] =  BLREA(X, Y, n, d);
y = [];
for i = 1:l
    Phix = [];
    for j = 1:d+1
        Phix = [Phix;x(i)^(j-1)];
    end
%    y = [y, normrnd(Mn'*Phix, beta^-1+Phix'*Sn*Phix)];
    y = [y, Mn'*Phix];
end
plot(x,y,'r');