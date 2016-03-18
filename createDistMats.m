% ======================================================================
% This code written by R. Michael Winters & Siddharth
% Date created: March 12, 2016
%
%> @brief creates distance mats for all reference tracks vs. the query track
%> called by :: searchAllNonZeroFrames
%>
%> @param q: The struct of the query track, including all features,
%> and non-zeroFrames
%> @param r: The struct of the query track, including all features,
%> and non-zeroFrames 
%>
%> @retval results: distMats for all reference tracks against the queryTrack 
% ======================================================================

function distMats = createDistMats(q, r)

numRefTracks = length(r.filenames);

for i = 1:numRefTracks
    eval(['distMats.r' num2str(i) '='....
        'pdist2(transpose(q.pC),transpose(r.r' num2str(i) '.pC));']);
end