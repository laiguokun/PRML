% x = -5:0.1:5;
% plot(x, normpdf(x,0,2) , 'r');
% hold on;
% plot(x, normpdf(x,1,1) , 'g');
% E = IS(1,1);
% disp(E);

% [E, S] = MH(2,2);
% disp([E,S]);

% u = [5;2;1];
% s = eye(d);
% [E, S] = Gibbs(u,s,3);

% d = 3;
% u = [3;1;2];
% s = eye(d) * 2;
% [E, S] = HMC(u,s,d);
% 
% disp(E);
% disp(S);

clear all;
close all;
n1=50;
n2=50;
n = n1 + n2;
d=2;
[X, Y] = getCdata(n1, n2, d);
T = zeros(1,n);
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
axis([-2 2 -2 2]);
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

k = 2;

[U,S] = MCEM(X, Y, k);
for i = 1:k
    plot(U(1,i),U(2,i), 'p','MarkerFaceColor','y');
    hold on;
end;
[x,y] = plotellipse(U(:,1),S{1});
plot(x,y,'b');
hold on;
[x,y] = plotellipse(U(:,2),S{2});
plot(x,y,'r');