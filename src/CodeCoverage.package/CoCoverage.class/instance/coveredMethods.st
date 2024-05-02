accessing
coveredMethods
	
	^ instrumentedMethods keys select: [ :e | self isCoveredMethod: e ]