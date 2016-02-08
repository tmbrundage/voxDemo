function [ffs, lbs, doc] = collectfeature(DAT, field, qgram, w)
% COLLECT FIELD FROM CELLS OF NAMED STRUCTURES
% inputs
%    DAT        cells of named-structured features
%    fieldname  feature's name, same as field name for each datum
% outputs
%    ffs        features vectors, as col matrix
%    lbs        labels, per feature vector
%    doc        which DAT cell it belongs to
% usage example:
%    DAT = loadAll();
%    collectfeature(DAT, 'chroma');

if (nargin < 3)
    qgram = 1;
end

if (nargin < 4)
    w = ones(1, qgram + qgram - 1);
end

ffs = [];
lbs = [];
doc = [];
for j = 1 : length(DAT)
    if (isempty(field))
        ff = DAT{j};
    elseif (isfield(DAT{j}, field))
        ff = getfield(DAT{j}, field);
    elseif (isfield(DAT{j}.stat, field))
        ff = getfield(DAT{j}.stat, field);
    else
        ff = getfield(DAT{j}.other, field);
    end
    if (qgram > 1)
        ff = inferqgram(ff, qgram, w);
    end
    
    ffs = [ffs ff];
    if (isempty(field))
    else
        lbs = [lbs DAT{j}.class * ones(1, size(ff, 2))];
    end
    doc = [doc j * ones(1, size(ff, 2))];
end


end