function [U,S] = VMG(X,k,d)
%Variational Mixture of Gaussians
    n = size(X,2);
    alpha0 = 1;
    beta0 = 1;
    W0 = eye(d);
    
    %initialize 
    U = rand(2,2);
    rnk = zeros(n,k);
    for i = 1:n
        s = 1;
        for j = 1:k-1
            rnk(i,j) = s * rand();
            s = s - rnk(i,j);
        end;
        rnk(i,k) = s;
    end;
    m0 = mean(X,2);
    v0 = d+1;
    L = -10000000;
    for iter = 1:2000
        N = sum(rnk);
        meanX = zeros(k,d);
        for i = 1:d
            meanX(:,i) = (rnk' * X(i,:)')';
        end
        for i = 1:k
            meanX(i,:) = meanX(i,:)/N(i);
        end;
        S = {};
        for i = 1:k
            S{i} = zeros(d,d);
            for j = 1:n
                S{i} = S{i} + rnk(j,i) * (X(:,j) - meanX(i,:)') * (X(:,j) - meanX(i,:)')';
            end
            S{i} = S{i}/N(i);
        end
        alphak = alpha0 + N;
        betak = beta0 + N;
        Mk = zeros(k,d);
        for i = 1:k
            Mk(i,:) = (beta0 * m0 + N(i) * meanX(i,:)')/betak(i);
        end
        Wk = {};
        for i = 1:k
            Wk{i} = N(i) * S{i} + ((beta0 * N(i))/(beta0 + N(i))) * (meanX(i,:)' - m0) * (meanX(i,:)' - m0)';
            Wk{i} = Wk{i} ^ -1;
        end
        vk = v0 + N;
        
%        disp(meanX);
        EUS = zeros(k,n);
        for i = 1:k
            for j = 1:n
                EUS(i,j) = d * betak(i) ^ -1 + vk(i) * (X(:,j) - Mk(i,:)')' * Wk{i} * (X(:,j) - Mk(i,:)');
            end
        end
        ES = zeros(k,1);
        for i = 1:k
            for j = 1:d
                ES(i) = ES(i) + psi((vk(i) + 1 - j)/2);
            end
            ES(i) = ES(i) + d * log(2) + log(det(Wk{i}));
        end;
        EPi = psi(alphak) - psi(sum(alphak));
        pnk = zeros(n,k);
        for i = 1:n
            for j = 1:k
                pnk(i,j) = EPi(j) + 0.5 * ES(j) - d * 0.5 * log(2 * pi) - 0.5 * EUS(j,i);
                pnk(i,j) = exp(pnk(i,j));
            end;
        end;
        rnk = zeros(n,k);
        for i = 1:n
            rnk(i,:) = pnk(i,:) / sum(pnk(i,:));
        end
%        disp(vk(1) * Wk{1});
%         %Lower bound
%         lastL = L;
%         L = 0;
%         for i = 1:k
%             L = L + 0.5 * N(i) * (ES(i) - d * betak(i) ^ -1 - vk(i) * trace(S{i} * W{i}) ...
%                 - vk(i) * (meanX(i,:)' - Mk(i,:)') * W{i} * (meanX(i,:)' - Mk(i,:)')' - d * ln(2*pi));
%         end;
%         for i = 1:n
%             for j = 1:k
%                 L = L + rnk(i,j) * Epi(j);
%             end;
%         end;
%         L = L + (alpha0 - 1) * sum(Epi);
%         for i = 1:k
%             L = L + 0.5 * (d * log(beta0/(2*pi)) + ES(i) - d * beta0 / betak(i) - beta0 * vk(i) * (Mk(i,:)' - m0));
%         end;        
%         L = L + k * ln
            
    end
    U = Mk';
    S = {};
    for i = 1:k
        S{i} = (vk(i) * Wk{i}) ^ -1;
    end;
    
        