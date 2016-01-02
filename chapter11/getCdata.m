function [X, Y] = getCdata(n1, n2, d)
%least squares for classification
    c1 = rand(d,1) * 2 - 1;
    c2 = rand(d,1) * 2 - 1;
    beta = sqrt(norm(c1-c2))/100;
    X1 = mvnrnd(c1,beta.*eye(d),n1);
    Y1 = ones(n1,1);
    X2 = mvnrnd(c2,beta.*eye(d),n2);
    Y2 = -ones(n2,1);
    X = [X1;X2]';
    Y = [Y1;Y2];
    disp(beta);
   