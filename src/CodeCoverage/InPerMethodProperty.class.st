Class {
	#name : 'InPerMethodProperty',
	#superclass : 'InSlot',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'binding creation' }
InPerMethodProperty >> additionalBindingsForMethod: aMethod forAnalysis: anAnalysis [
	"I'm a per method property, just return a single binding"

	| defaultValue |
	defaultValue := anAnalysis
		                perform: self name , #DefaultValueForMethod:
		                with: aMethod.
	^ { (self name -> defaultValue) }
]

{ #category : 'accessing' }
InPerMethodProperty >> nameForStatementAt: anInteger [ 
	
	^ name
]
