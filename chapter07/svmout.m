function out = svmout(alpha, b, X, Y, n, i2)
    kernel = @(xn,xm) xn'*xm;
    out = b;
    for i = 1:n
        out = out + alpha(i) * Y(i,1) * kernel(X(:,i), X(:,i2));
    end
    
     
    