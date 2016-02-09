
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FV Concatenating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change this to the directory containing your data folder
dirn = '/Users/Ted/__Princeton/__G2_Spring/__COS_424/voxDemo/';

% add tools path
run('/Users/Ted/__RandomCode/vlfeat-0.9.20/toolbox/vl_setup')
addpath(genpath('/Users/Ted/__Princeton/__G2_Spring/__COS_424/voxDemo/tools'))


[DAT, LB, FNS] = loadAll(dirn);

%extract the Chroma Sums
chroma = cell(1,length(DAT));

for i = 1:length(DAT)
    chroma{i} = sum(DAT{i}.chroma,2);
end
save('Chroma.mat','chroma')