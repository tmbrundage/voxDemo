
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FV Concatenating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change this to the directory containing your data folder
dirn = '/Users/Ted/__Princeton/__G2_Spring/__COS_424/voxDemo/';

% add tools path
run('/Users/Ted/__RandomCode/vlfeat-0.9.20/toolbox/vl_setup')
addpath(genpath('/Users/Ted/__Princeton/__G2_Spring/__COS_424/tools'))


[DAT, LB, FNS] = loadAll(dirn);

%extract the MFCC
mfcc = cell(1,1000);

for i = 1:length(DAT)
    mfcc{i} = DAT{i}.mfc;
end

%create the structure used as input into the demo_fv
GENDATA.data = mfcc;
GENDATA.class = LB;
GENDATA.classnames = {'Blues', 'Classical', 'Country', 'Disco', 'Hiphop',...
	'Jazz', 'Metal', 'Pop', 'Reggae', 'Rock'};
%run fisher vector
FV = demo_fv(GENDATA, 3, 3);