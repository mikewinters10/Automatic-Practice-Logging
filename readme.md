# Automatic Practice Logging
A library for automatic classification of repertoire practice. 

## Simple instructions to get up and running
1. Run 'initWorkspace'
	* Loads the reference structures, and default settings for hopSize, winSize, and fs
2. Run 'q = createFeatureMatrix('140602-000.mp3')'
	* This creates a query matrix that we will compare to reference tracks
3. Run 'searchAllNonZeroFrames(q, r)
	* This function searches the query track for best matches, ignoring frames with too much silence
