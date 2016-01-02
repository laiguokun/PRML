clear all;
close all;
n1=20;
n2=20;
n = n1 + n2;
d=2;
[X, Y] = getCdata(n1, n2, d);
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
axis([-0.5 1.5 -0.5 1.5]);
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

k = 2;

% [u] = kmean(X, Y, k);
% for i = 1:k
%     plot(u(1,i),u(2,i), 'p','MarkerFaceColor','r');
%     hold on;
% end;
% x = 0:0.01:1;
% A = u(:,1) - u(:,2);
% t = (u(:,1) + u(:,2))./2;
% b = -A' * t;
% y = (-x*A(1,1) - b)/ A(2,1);
% plot(x,y,'r');

[U,S,P] = EM(X, Y, k);
for i = 1:k
    plot(U(1,i),U(2,i), 'p','MarkerFaceColor','y');
    hold on;
end;
[x,y] = plotellipse(U(:,1),S{1});
plot(x,y,'b');
hold on;
[x,y] = plotellipse(U(:,2),S{2});
plot(x,y,'r');
