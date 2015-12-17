function [X,Y] = getdata(n,beta)
% get regression train data base on the sin function

X = rand(n,1) * 2 * pi;
Y = sin(X) + normrnd(0, 1.0/beta, [n,1]);
