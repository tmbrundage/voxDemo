function [ds2, mapping, mtp] = inferqgram( ds, k, w )
%DS_CONSTRCUT construct a smoothen dataset from a dataset
% INPUT
%   ds : original dataset, in column matrix, i.e. ds(:,i) is a datum
%   k  : smoothing length
%   w  : weights for each dimension
% OUTPUT
%   ds2: the smoothened dataset
%   mapping: mapping from the original dataset to the new dataset, in index
%   mtp: multiplier for the distance metric

if (nargin < 3)
    w = ones(1, k+k-1);
end

if (iscolumn(w)), w = w'; end
mtp = repmat(w, size(ds, 1), 1);
mtp = mtp(:);

if (length(w) ~= k+k-1)
    error('The dimension of [w] should be equal to k+k-1');
end

ds2 = zeros(size(ds,1) * (k+k-1), size(ds, 2)-(k+k));

mapping = k : size(ds, 2) - k + 1;

for j = mapping
    d = ds(:, (j-k+1):(j+k-1));
    ds2(:, j-k+1) = d(:) .* mtp;
end

end

