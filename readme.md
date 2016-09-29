# Automatic Practice Logging
A library for automatic classification of repertoire practice. 

## Simple instructions to get up and running
1. Run 'initWorkspace'
	* Loads the reference structures, and default settings for hopSize, winSize, and fs
2. Run 'q = createFeatureMatrix('140505-005.mp3', bigHopSize, bigWinSize, removeSilence)'
	* This creates a query matrix that we will compare to reference tracks
3. Run 'q = searchAllNonZeroFrames(q, r)
	* This function searches the query track for best matches, ignoring frames with too much silence
4. Run 'plotMinFrames(q)'
	* This will plot the results.
