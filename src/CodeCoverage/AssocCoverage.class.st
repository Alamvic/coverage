Class {
	#name : 'AssocCoverage',
	#superclass : 'LineCoverage',
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
