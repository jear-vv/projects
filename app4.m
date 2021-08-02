%% Load Data

load('C:\TrainDATAtoyGaussian1D.mat','x1');
X = TrainDATAtoyGaussian1D';   % 300x3 data set
K = 2; % number of Gaussian Mixture components

% Initialization
p = [0.2, 0.3, 0.2, 0.3]; % arbitrary pi
[idx,mu] = kmeans(X,K); % initial means of the components

% compute the covariance of the components
sigma = zeros(D,D,K);
for k = 1:K
    sigma(:,:,k) = cov(X(idx==k,:));
end


% variables for convergence 
converged = 0;
prevLoglikelihood = Inf;
prevMu = mu;
prevSigma = sigma;
prevPi = p;
round = 0;
while (converged ~= 1)
    round = round +1
    gm = zeros(K,N); % gaussian component in the nominator
    sumGM = zeros(N,1); % denominator of responsibilities
    % E-step:  Evaluate the responsibilities using the current parameters
    % compute the nominator and denominator of the responsibilities
    for k = 1:K
        for i = 1:N
             Xmu = X-mu;
             % I am using log to prevent underflow of the gaussian distribution (exp("small value"))
             logPdf = log(1/sqrt(det(sigma(:,:,k))*(2*pi)^D)) + (-0.5*Xmu*(sigma(:,:,k)\Xmu'));
             gm(k,i) = log(p(k)) * logPdf;
             sumGM(i) = sumGM(i) + gm(k,i);
         end
    end

    
    % calculate responsibilities
    res = zeros(K,N); % responsibilities
    Nk = zeros(4,1);
    for k = 1:K
        for i = 1:N
            % I tried to use the exp(gm(k,i)/sumGM(i)) to compute res but this leads to sum(pi) > 1.
            res(k,i) = gm(k,i)/sumGM(i);
        end
        Nk(k) = sum(res(k,:));
    end
    
    % M-step: Re-estimate the parameters using the current responsibilities
    for k = 1:K
        for i = 1:N
            mu(k,:) = mu(k,:) + res(k,i).*X(k,:);
            sigma(:,:,k) = sigma(:,:,k) + res(k,i).*(X(k,:)-mu(k,:))*(X(k,:)-mu(k,:))';
        end
        mu(k,:) = mu(k,:)./Nk(k);
        sigma(:,:,k) = sigma(:,:,k)./Nk(k);
        p(k) = Nk(k)/N;
    end
    
    % Evaluate the log-likelihood and check for convergence of either 
    % the parameters or the log-likelihood. If not converged, go to E-step.
    loglikelihood = 0;
    for i = 1:N
        loglikelihood = loglikelihood + log(sum(gm(:,i)));
    end


    % Check for convergence of parameters
    errorLoglikelihood = abs(loglikelihood-prevLoglikelihood);
    if (errorLoglikelihood <= eps)
        converged = 1; 
    end

    errorMu = abs(mu(:)-prevMu(:));
    errorSigma = abs(sigma(:)-prevSigma(:));
    errorPi = abs(p(:)-prevPi(:));

    if (all(errorMu <= eps) && all(errorSigma <= eps) && all(errorPi <= eps))
        converged = 1;
    end

    prevLoglikelihood = loglikelihood;
    prevMu = mu;
    prevSigma = sigma;
    prevPi = p;

end % while 