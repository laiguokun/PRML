function [U,S,P,A] = HMM(x,k,u)
%Hiddden Markov Models
    [d,n] = size(x);
    U = u;
    S = zeros(d,d,k);
    for i = 1:k
        S(:,:,i) = 0.1 * eye(d);
    end
    P = ones(k,1)/k;
    A = ones(k)/k;

    for iter = 1:20
        %E step
        %use the forward-backward algorithm
        alpha = zeros(n,k);
        for j = 1:k
            alpha(1,j) = P(j,1) * mvnpdf(x(:,1), U(j,:)', S(:,:,j));
        end
        cn = zeros(n,1);
        alpha(1,:) = alpha(1,:)/norm(alpha(1,:),1);
        for i = 2:n
            for j = 1:k
                alpha(i,j) = mvnpdf(x(:,i), U(j,:)', S(:,:,j)) * (alpha(i-1,:) * A(:,j));
            end
            cn(i) = norm(alpha(i,:),1);
            alpha(i,:) = alpha(i,:)/cn(i);
        end
        beta = zeros(n,k);
        beta(n,:) = ones(1,k);
        for i = n-1:-1:1
            for j = 1:k
                for t = 1:k
                    beta(i,j) = beta(i,j) + beta(i+1,t) * mvnpdf(x(:,i+1), U(t,:)', S(:,:,t)) * A(j,t);
                end
            end
            beta(i,:) = beta(i,:)/cn(i+1);
        end
        
        gamma = zeros(n,k);
        for i = 1:n
            gamma(i,:) = alpha(i,:).*beta(i,:);
        end
        
        xi = zeros(n,k,k);
        for i = 2:n
            for j = 1:k
                for t = 1:k
                    xi(i,j,t) = cn(i)^-1 * alpha(i-1,j) * mvnpdf(x(:,i), U(t,:)', S(:,:,t)) * A(j,t) * beta(i,t);
                end
            end
        end
%        disp(beta);
%        disp(xi);
        %M step
        U = zeros(k,d);
        for i = 1:k
            nk = 0;
            for j = 1:n
                nk = nk + gamma(j,i);
                U(i,:) = U(i,:) + gamma(j,i) * x(:,j)';
            end
            U(i,:) = U(i,:)/nk;
        end
        
        S = zeros(d,d,k);
        for i = 1:k
            nk = 0;
            for j = 1:n
                nk = nk + gamma(j,i);
                S(:,:,i) = S(:,:,i) + gamma(j,i) * (x(:,j) - U(i,:)') * (x(:,j) - U(i,:)')';
            end
            S(:,:,i) = S(:,:,i)/nk;
        end;
        
        P = zeros(k,1);
        nk = 0;
        for i = 1:k
            P(i) = gamma(1,i);
            nk = nk + gamma(1,i);
        end
        P = P / nk;
        
        A = zeros(k,k);
        for i = 1:k
            nk = 0;
            for j = 1:k
                for t = 2:n
                    A(i,j) = A(i,j) + xi(t,i,j);
                    nk = nk + xi(t,i,j);
                end;
            end;
            A(i,:) = A(i,:) / nk;
        end
    end
    