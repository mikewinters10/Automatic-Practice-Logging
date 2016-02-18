function dist = distanceMapping(qPC, rPC, qSC, rSC);

% Define distances independently based upon the absolute mean error.
pCDist = mae(qPC - rPC);

% The Question of feature normalization for the spectral centroid.
sCDist = mae(qSC - rSC);

dist = pCDist;