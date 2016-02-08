#!/usr/bin/python


#########################################################################
####  Ted Brundage, M.S.E., Princeton University
####  Advisor: Barbara Engelhardt
####
####  Code: MAT2CSV.py
####
####  Last updated: 1/29/16
####
####  Notes and disclaimers:
####    Writes arrays stored within .mat structs as individual .csv files 
####    Names of .mat files should be given as command line arguments. 
####
#########################################################################

import sys
import scipy.io as spio
import numpy as np

def _todict(matobj):
    dict = {}
    for strg in matobj._fieldnames:
        elem = matobj.__dict__[strg]
        if isinstance(elem, spio.matlab.mio5_params.mat_struct):
            dict[strg] = _todict(elem)
        else:
            dict[strg] = elem
    return dict

def recSave(fn, d):
    DONOTSAVE = ['class_name','filename']
    for key, val in d.iteritems():
        if key not in DONOTSAVE:
            if isinstance(val, dict):
                recSave('%s_%s' % (fn, key), val)
            else:
                print type(val)
                if isinstance(val, int): 
                    np.savetxt('%s_%s.csv' %(fn,key),[val],delimiter=',')
                elif isinstance(val,np.ndarray):
                    np.savetxt('%s_%s.csv' %(fn,key),val,delimiter=',')
                else:
                    print 'Value not of recognized type'

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'Arguments must include filenames.'
    else:
        DONOTSAVE = ['__version__', '__header__','__globals__']
        for fn in sys.argv[1:]:
            X = spio.loadmat(fn, struct_as_record=False, squeeze_me=True)
            for name, vals in X.iteritems():
                if name not in DONOTSAVE:
                    d = _todict(vals)
                    recSave('%s_%s' % (fn[:-4], name), d)


