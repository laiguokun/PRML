grad_U = @(q) q;
p = 0;
q = 1;
current_p = p;
epsilon = 0.3;
L = 20;
for i = 1:L
    p = p - epsilon * grad_U(q) / 2;
    q = q + epsilon * p;
    p = p - epsilon * grad_U(q) / 2;
    plot(p,q,'o');
    hold on;
end
axis([-2 2 -2 2]);
% p = p - epsilon * grad_U(q) / 2;
% plot(p,q, 'o');
% hold on;

theta=0:pi/50:2*pi;
x=cos(theta);
y=sin(theta);
plot(x,y,'-');
hold on;