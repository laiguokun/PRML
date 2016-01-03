function [X] = HMMsample(u,s,a,p,n)
%Hidden Markove Models sample data
    k = size(u,1);
    t = rand();
    tmp = 0;
    z = 0;
    for i = 1:k
        tmp = tmp + p(i);
        if (t < tmp)
            z = i;
            break;
        end
    end
    
    X = [];
    Z = [];
    for iter = 1:n
        X = [X,mvnrnd(u(z,:)',s(:,:,z))'];
        t = rand();
        tmp = 0;
        for i = 1:k
            tmp = tmp + a(z,i);
            if (t < tmp)
                z = i;
                break;
            end
        end
        Z = [Z,z];
    end
%    disp(mean(Z));
                