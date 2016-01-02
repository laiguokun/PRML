function [U,S,P] = EM(X, Y, k)
    
    n = size(X,2);
    d = size(X,1);
    
    U = rand(d,k);
    S = {};
    for i = 1:k
        S{i} = eye(d);
    end
    P = ones(k,1) / k;
    
    MLE = 0;
    for i = 1:n
        t = 0;
        for j = 1:k
           t = t + P(j) * mvnpdf(X(:,i),U(:,j),S{j});
        end
        MLE = MLE + log(t);
    end
    
    for iter = 1:100
        %E step
        N = zeros(k,1);
        gamma = zeros(n,k);
        for i = 1:n
            s = 0;
            for j = 1:k
                s = s + P(j) * mvnpdf(X(:,i),U(:,j),S{j}); 
            end
            for j = 1:k
                gamma(i,j) = P(j) * mvnpdf(X(:,i),U(:,j),S{j})/s;
                N(j) = N(j) + gamma(i,j);
            end
        end
        %M step
        for i = 1:k
            for j = 1:d
                U(j,i) = sum(gamma(:,i)' .* X(j,:))/N(i);
            end
        end
        
        for i = 1:k
            for j = 1:n
                S{i} = S{i} + gamma(j,i) * (X(:,j) - U(:,i)) * (X(:,j) - U(:,i))';
            end
            S{i} = S{i} / N(k);
        end
        
        for i = 1:k
            P(k) = N(k)/n;
        end
        
        %evaluate
        tmp = 0;
        for i = 1:n
            t = 0;
            for j = 1:k
               t = t + P(j) * mvnpdf(X(:,i),U(:,j),S{j});
            end
            tmp = tmp + log(t);
        end
        if (tmp < MLE + 1e-6)
%            break;
        else
            MLE = tmp;
        end
    end
    
        
        
        
            
                