function [U,S] = MCEM(X, Y, k)
   
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
    
    for iter = 1:1000
        %E step
%         disp(U);
%         for i = 1:k
%             disp(S{i});
%         end;
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
        
        sample = {};
        for i = 1 : k
            sample{i} = [];
        end
        ss = 0;
        for tt = 1:10
            for i = 1:n 
                s = 0;
                r = 0;
                x = rand();
                for j = 1:k
                    s = s + gamma(i,j);
                    if (x < s)
                        r = j;
                        break;
                    end;
                end;
                sample{r} = [sample{r}; X(:,i)'];
            end;
            ss = ss + n;
        end;
        for i = 1 : k
            if (size(sample{i},1) > 0)
                U(:,i) = mean(sample{i});
                S{i} = cov(sample{i});
            end;
            P(i) = size(sample{i},1)/ss;
        end;
    end
    
        
        
        
            
                