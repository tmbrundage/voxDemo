function FV = demo_fv(GENDATA, numClusters, exemplarsize)
%input into this function is a struct that contains the following elements
% GENDATA.data - A cell array of matrices where each cell corresponds to
% a feature matrix from each song
% GENDATA.class - Class labels {1-10}
% GENDATA.classnames - classnames (order corresponds to labels)
% optional aurguments: numClusters is the number of guassian mixture
% components, exemplarsize range of temporal information captured.  This is
% an odd number that should fall in the range of [3-13].  Note: 16gb RAM is
% is recomended for exemplarsize > 5 and the function may take time to run.
% OUTPUT: The resulting feature vector's size is exemplarsize * 2 - 1 times
% the original feature size.

% Load GENDATA
%if (~exist('GENDATA', 'var')), error('Data not loaded'); end;

% number of Gaussian components
if nargin < 3
    exemplarsize = 3;
end
if nargin < 2 
    numClusters = 10;
end
if mod(exemplarsize,2) == 0 
    exemplarsize = exemplarsize - 1;
end

%% convert frame-level features to exemplars
% the bigger the exemplar, the more temporal info captured.
% recommended value for exemplarsize = 5. 
% The resulting feature vector's size is exemplarsize * 2 - 1 times
% the original feature size.
EXE = cell(length(GENDATA.data), 1);
for j = 1 : length(GENDATA.data)
    EXE{j} = inferqgram(GENDATA.data{j}, exemplarsize);
end

%% collect all exemplar features into a big matrix. 
allexedata = collectfeature(EXE, []);

% You may consider using PCA to reduce the dimensionality of your exemplars
% here. Because the dimensionality of FV is 
%   (the dimension of your exemplar) x (num of Gaussian components) x 2

% compute GMM
[means, covariances, priors] = vl_gmm(allexedata, numClusters);

%% compute Fisher Vector, 
% stored in FV. Each exemplar corresponds to a column
FV = zeros(numel(means)*2, length(GENDATA.data));
for j = 1 : length(GENDATA.data)
    FV(:,j) = vl_fisher(EXE{j}, means, covariances, priors, 'Improved');
end
end