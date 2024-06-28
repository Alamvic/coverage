Class {
	#name : 'AssocCoverage',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerStatementProperty'
	],
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'instrumenting' }
AssocCoverage >> additionalBindings: instrumentation [

	| bindings |
	bindings := (1 to: instrumentation second) collect: [ :i |
		            AdditionalBinding
			            key: ('COVERAGE_' , i asString) asSymbol
			            value: nil ].

	^ bindings
]

{ #category : 'instrumenting' }
AssocCoverage >> afterStatement: statement at: index [

	coverage := #complete
]

{ #category : 'instrumenting' }
AssocCoverage >> beforeSequence: aSequence at: anIndex [

	coverage := #complete
]

{ #category : 'instrumenting' }
AssocCoverage >> beforeStatement: statement at: index [

	coverage := #partial
]

{ #category : 'accessing' }
AssocCoverage >> coverageOf: aMethod [

	| instrumentedMethod |
	instrumentedMethod := instrumentedMethods at: aMethod.
	^ (instrumentedMethod literals
		   select: [ :e | e isKindOf: AdditionalBinding ]
		   thenCollect: [ :e | e value value ]) value
]

{ #category : 'instrumenting' }
AssocCoverage >> newCoverageStatementAt: index value: value [

	^ RBAssignmentNode
		  variable:
		  (RBVariableNode named: ('COVERAGE_' , index asString) asSymbol)
		  value: (RBLiteralNode value: value)
]
