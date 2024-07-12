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

	^ aMethod ast allSequenceNodes flatCollect: [ :e |
		  (0 to: e statements size) collect: [ :i |
			  AdditionalBinding
				  key: (self nameForStatementAt: i)
				  value: defaultValue ] ]
]

{ #category : 'accessing' }
InPerStatementProperty >> nameForStatementAt: anInteger [ 
	
	^ name, '_', anInteger asString
]
