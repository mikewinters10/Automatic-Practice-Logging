% This function seeks to find the most similar sub-vectors in a test-vector
% to a given query. It returns number of Matches.

function Matches = findMostSimilarBlocks_NoComp(query,reference, numberOfMatches)

Matches = ones(2,numberOfMatches);
lengthReference = size(reference,2);
lengthQuery = size(query,2);

for i=1:(lengthReference-lengthQuery+1)
    
   similarity = mae(query, reference(:,i:i+lengthQuery-1));
   
   for j=1:numberOfMatches
       % If this match is greater than the similarity,
       if Matches(2,j) > similarity
           if j<numberOfMatches
              Matches((j+1:end),:) = Matches(j:(end-1),:);
           end     
           Matches(:,j) = [i; similarity];
           break
       end
   end
end

