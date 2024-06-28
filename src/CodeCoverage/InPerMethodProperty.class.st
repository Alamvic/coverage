Class {
	#name : 'InPerMethodProperty',
	#superclass : 'InSlot',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'binding creation' }
InPerMethodProperty >> additionalBindingsForMethod: aMethod forAnalysis: anAnalysis [
	"I'm a per method property, just return a single binding"

	| binding |
	binding := anAnalysis
		           perform: #initialize_ , self name , #':forMethod:'
		           with: self name -> nil
		           with: aMethod.
	^ { binding }
]

{ #category : 'accessing' }
InPerMethodProperty >> nameForStatementAt: anInteger [ 
	
	^ name
]
