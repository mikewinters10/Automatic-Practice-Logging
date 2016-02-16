% This function seeks to find the most similar sub-vectors in a test-vector
% to a given query. It returns number of Matches.

function matches = findMostSimilarBlocks(queryVec,testVec, numOfBlocksToTest, numberOfMatches)

matches = ones(2,numberOfMatches);
lengthTestVec = size(testVec,2);
lengthQueryVec = size(queryVec,2);

for i=1:(lengthTestVec-numOfBlocksToTest+1)
   similarity = mae(mean(queryVec,2), mean(testVec(:,i:i+numOfBlocksToTest-1),2));
   for j=1:numberOfMatches
       if matches(2,j) > similarity
           if j<numberOfMatches
              matches((j+1:end),:) = matches(j:(end-1),:);
           end     
           matches(:,j) = [i; similarity];
           break
       end
   end
end

