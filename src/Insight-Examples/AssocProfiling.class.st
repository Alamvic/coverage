Class {
	#name : 'AssocProfiling',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerStatementPropertySlot'
	],
	#category : 'Insight-Examples',
	#package : 'Insight-Examples'
}

{ #category : 'instrumenting' }
AssocProfiling >> afterStatement: statement at: index [

	coverage := coverage + 0.5
]

{ #category : 'instrumenting' }
AssocProfiling >> beforeSequence: aSequence at: index [

	coverage := coverage + 1.0
]

{ #category : 'instrumenting' }
AssocProfiling >> beforeStatement: statement at: index [

	coverage := coverage + 0.5
]

{ #category : 'default values' }
AssocProfiling >> coverageDefaultValueForMethod: aMethod [ 
	
	^ 0.0
]

{ #category : 'accessing' }
AssocProfiling >> coverageOf: aMethod [

	| instrumentedMethod |
	instrumentedMethod := instrumentedMethods at: aMethod.
	^ (instrumentedMethod literals
		   select: [ :e | e isKindOf: AdditionalBinding ]
		   thenCollect: [ :e | e value value ]) value
]
