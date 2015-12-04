clear all;
close all;
n1 = 20;
n2 = 20;
n = n1 + n2;
d=2;
[X, Y] = getCdata(n1, n2, d);
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

x = 0:0.1:1;
y = [];

theta0 = 1;
theta1 = 4;
theta2 = 0;
theta3 = 0; 
kernel = @(xn,xm,theta0,theta1,theta2,theta3) theta0 * exp(- (theta1/2) * norm(xn-xm)^2) + theta2 + theta3 * xn' * xm;

[an] = GPC(X, Y, n1+n2, theta0, theta1, theta2, theta3);
sn = sigmf(an, [1,0]);
dec = [];
for i = 1:size(x,2)
    syms tmp;
    k = [];
    for j = 1:n
        k = [k; theta0 * exp(- (theta1/2) * ((X(1,j)-x(i))^2 + (X(2,j)-tmp)^2))];
    end;
    f = k'*(Y - sn);
    res = solve(f);
    for j = 1:size(res,1)
        dec = [dec; [x(i), double(res(j))]];
    end
end
plot(dec(:,1), dec(:,2), 'o', 'MarkerFaceColor', 'r');