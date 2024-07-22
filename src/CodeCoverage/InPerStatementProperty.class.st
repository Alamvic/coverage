Class {
	#name : 'InPerStatementProperty',
	#superclass : 'InSlot',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'binding creation' }
InPerStatementProperty >> additionalBindingsForMethod: aMethod forAnalysis: anAnalysis [
	"I'm a per statement property, compute all necessary statements and create a binding per each"

	| defaultValue |
	defaultValue := anAnalysis
		                perform: self name , #DefaultValueForMethod:
		                with: aMethod.

	^ anAnalysis hooks flatCollect: [ :hook |
		  hook
			  additionalBindingsForProperty: self
			  inMethod: aMethod
			  withinAnalysis: anAnalysis ]
]

{ #category : 'accessing' }
InPerStatementProperty >> nameForStatementAt: anInteger [ 
	
	^ name, '_', anInteger asString
]
