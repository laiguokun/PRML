function [U,S] = HMC(u,s,d)
%hybird Monte Carlo Algorithm for N(X|u,s)
    grad_U = @(q,u,s) (s^-1 * (q - u));
    sample = [];
    head = 100;
    tail = 500;
    current_q = zeros(d,1);
    current_p = zeros(d,1);
    epsilon = 0.25;
    L = 30;
    cnt = 0;
    for iter = 1:tail
        q = current_q;
        p = mvnrnd(zeros(d,1), eye(d))';
	   	current_p = p;
        p = p - epsilon * grad_U(q,u,s) / 2;	   	
	   	for i = 1:L
	   		q = q + epsilon * p;
	   		if (i ~= L) 
                p = p - epsilon * grad_U(q,u,s);
            end
	   	end
	   	p = p - epsilon * grad_U(q,u,s) / 2;
	   	p = -p;
	   	current_U = (current_q - u)' * s ^ -1 * (current_q - u) * 0.5;
	   	current_K = (current_p' * current_p) * 0.5;
	   	proposed_U = (q - u)' * s ^ -1 * (q - u) * 0.5;
	   	proposed_K = (p' * p) * 0.5;
	   	if (rand() < exp(current_U - proposed_U + current_K - proposed_K))
	   		current_q = q;
            cnt = cnt + 1;
        end
        if (iter > head)
            sample = [sample; current_q'];
        end;
    end
    disp(cnt);
    disp(cnt/tail);
	U = mean(sample);
	S = cov(sample);