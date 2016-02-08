function [D, LB, FNS] = loadAll(dirn)
%%Load the raw data into a single matlab struct.  
% usage: [dat, lb, fns] = loadAll(dirname)
% dirname is your path to the processed directory.  The data is outputted
% as a cell array, dat for each song.   

dirn = [dirn '/data'];

ctgdirns = dir(dirn);
D = {};
LB = [];
FNS = {};

count = 1;

for j = 1 : length(ctgdirns)
    ctg = ctgdirns(j).name;
    if (ctg(1) == '.'), continue; end;
    fns = dir([dirn '/' ctg]);
    for i = 1 : length(fns)
        fn = fns(i).name;
        if (fn(1) == '.'), continue; end;
        load([dirn '/' ctg '/' fn]);
        D{count} = DAT;
        count = count + 1;
        LB = [LB, DAT.class];
        FNS{length(FNS) + 1} = fn;
    end
end


end