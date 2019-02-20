function [snr] = function_snr(X, n_keys, labels)

n_samples = size(X,2);
%%
X = X - min(X(:));
X = X / max(X(:));
X = (X - mean(X,1))./var(X,[],1);

%%
class = cell(1,n_keys);
mu = zeros(n_keys, n_samples);
sigma2 = zeros(n_keys,n_samples);
for i=1:n_keys
    index = labels==i;
    class{i} = X(index,:);
    mu(i,:) = mean(class{i},1);
    sigma2(i,:) = var(class{i},[],1);
end

snr = var(mu,[],1) ./ mean(sigma2,1);

end

