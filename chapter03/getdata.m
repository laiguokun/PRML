function [X,Y] = getdata(W, n, d, beta)
% get train data based on the W is the basis, phi is x^i, n is the number of data, d is the
% dimendsion of the data

X = rand(n,1);
Phi = [ones(1,n)];
for i = 1:d
    Phi = [Phi; (X.^i)'];
end
Y = (W' * Phi)' + normrnd(0, 1.0/beta, [n,1]);
