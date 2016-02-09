%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FV Concatenating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change this to the directory containing your data folder
dirn = '/Users/Gazelle/Documents/voxDemo/';

% add tools path
addpath(genpath('/Users/Gazelle/Documents/voxDemo/tools'))

[DAT, LB, FNS] = loadAll(dirn);

%extract the MFCC
mfcc = cell(1,length(DAT));

for i = 1:length(DAT)
    mfcc{i} = DAT{i}.mfc;
end

save FullSongs mfcc LB