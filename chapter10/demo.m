clear all;
close all;
n1=50;
n2=50;
n = n1 + n2;
d=2;
[X, Y] = getCdata(n1, n2, d);
T = zeros(1,n);
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
axis([-0.5 1.5 -0.5 1.5]);
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

k = 2;

% [U,S] = VIUG(X);
% x = -0.5:0.01:1.5;
% y = normpdf(x,U, S^0.5);
% disp(S^0.5);
% plot(x,y,'r');

% [U,S] = VMG(X, k, d);
% for i = 1:k
%     plot(U(1,i),U(2,i), 'p','MarkerFaceColor','y');
%     hold on;
% end;
% [x,y] = plotellipse(U(:,1),S{1});
% plot(x,y,'b');
% hold on;
% [x,y] = plotellipse(U(:,2),S{2});
% plot(x,y,'r');

[W,S] = VLogR(X, Y);
ezplot(@(x,y)myfun(x,y,S(1,1),S(1,2),S(1,3),S(2,1),S(2,2),S(2,3),S(3,1),S(3,2),S(3,3),W(1,1),W(2,1),W(3,1)),[0,1]);