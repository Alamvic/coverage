Class {
	#name : 'LineCoverage',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerMethodPropertySlot'
	],
	#category : 'Insight-Examples',
	#package : 'Insight-Examples'
}

{ #category : 'instrumenting' }
LineCoverage >> afterStatement: statement at: index [

	coverage := #complete
]

{ #category : 'instrumenting' }
LineCoverage >> beforeSequence: aSequence at: anIndex [

	coverage := #complete
]

{ #category : 'instrumenting' }
LineCoverage >> beforeStatement: statement at: index [

	coverage := #partial
]

{ #category : 'default values' }
LineCoverage >> coverageDefaultValueForMethod: aCollection [ 
	
	^ Array new: 100 withAll: 0
]

{ #category : 'accessing' }
LineCoverage >> coverageOf: aMethod [

	| instrumentedMethod |
	instrumentedMethod := instrumentedMethods at: aMethod.
	^ (instrumentedMethod literals
		   select: [ :e | e isKindOf: AdditionalBinding ]
		   thenCollect: [ :e | e value value ]) value
]

{ #category : 'accessing' }
LineCoverage >> initialize_coverage: coverageBinding forMethod: aMethod [

	| coverageEntries |
	coverageEntries := aMethod ast allSequenceNodes sum: [ :e |
		                   e statements size + 1 ].
	coverageBinding value: (Array new: coverageEntries).
	^ coverageBinding
]
