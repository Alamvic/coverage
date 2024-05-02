api
measureCoverageOfMethods: aCollection during: aFullBlockClosure 
	
	| coverage |
	coverage := self new.
	aCollection do: [ :m | coverage instrument: m ].
	aFullBlockClosure ensure: [ 
		coverage release ].
	^ coverage