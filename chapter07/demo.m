clear all;
close all;
n1=20;
n2=20;
% n1 = 1;
% n2 = 1;
n = n1 + n2;
d=2;
[X, Y] = getdata(n1, n2, d);
%X = [0.38,0.62;0.55,0.70];
%Y = [1;-1];
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

C = 1000;
[alpha, b] = svm_smo(X, Y, n1+n2, C);
W = zeros(2,1);
for i = 1:n1+n2
    W = W + alpha(i) * Y(i) * X(:,i);
    if (alpha(i) > 0 && alpha(i) < C)
        plot(X(1,i), X(2,i),'o','MarkerFaceColor','y');
        hold on;
    end
end;

x = 0:0.01:1;
y = (-W(1,1) * x - b)/ W(2,1);
plot(x,y,'r');
