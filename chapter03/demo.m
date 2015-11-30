d = 3;
n = 100;
W = rand(d+1,1);
beta = 100;
[X, Y] = getdata(W, n, d, beta);
[Wml, betaml] = MLE(X, Y, n, d);
