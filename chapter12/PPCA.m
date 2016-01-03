function [X] = PPCA(x,m)
%use EM algorithm to implement the probabilistic PCA
    [d,n] = size(x);
    xmean = mean(x')';
    W = rand(d,m);
    S = 0.1;
    ene = 0;
    for iter = 1:100
        M = W' * W + S * eye(m);
        Ez = zeros(n,m);
        Ezz = zeros(n,m,m);
        for i = 1:n
            Ez(i,:) = M^-1 * W' * (x(:,i) - xmean);
            Ezz(i,:,:) = S * M^-1 + Ez(i,:) * Ez(i,:)'; 
        end
        X = W * Ez' + xmean(:,ones(1,n));
        W = ((x - xmean(:,ones(1,n))) * Ez) * (sum(Ezz(:,:,:),1) ^ -1);
        S = 0;
        for i = 1:n
            S = S + norm(x(:,i) - xmean)^2;
            S = S - 2 * Ez(i,:) * W' * (x(:,i) - xmean);
            S = S + trace(Ezz(i,:,:) * (W' * W));
        end
        S = S / (n * d);
        
%         ene = 0;
%         for i = 1:n
%             ene = ene + d * 0.5 * log(2*pi*S);
% %             ene = ene + 0.5 * trace(Ezz(i,:,:));
% %             ene = ene + 0.5 * (1/S) * norm(x(:,i) - xmean);
% %             ene = ene - (1/S) * Ez(i,:) * W' * (x(:,i) - xmean);
% %             ene = ene + 0.5 * (1/S) + trace(Ezz(i,:,:) * W' * W);
%         end;
%         ene = -ene;
%         disp(ene);
    end
    