beta = 10;
n = 30;
[X, Y] = getRdata(n, beta);
plot(X,Y, '.','MarkerFaceColor', 'g');
hold on;

x = 0:0.01:2*pi;
y = [];

% for i = 1:size(x,2)
%     y(i) = NWM(X, Y, n, 1, x(i));
% end
% plot(x,y, 'r');

theta0 = 1;
theta1 = 4;
theta2 = 0;
theta3 = 0; 
kernel = @(xn,xm,theta0,theta1,theta2,theta3) theta0 * exp(- (theta1/2) * norm(xn-xm)^2) + theta2 + theta3 * xn' * xm;
[C] = GPR(X, Y, n, beta, theta0, theta1, theta2, theta3);

for i = 1:size(x,2)
    k = zeros(n,1);
    for j = 1:n
        k(j,1) = kernel(X(j), x(i), theta0, theta1, theta2, theta3);
    end
    y(i) = k' * C^-1 * Y;
end
plot(x, y, 'r');
    


