Class {
	#name : 'LineProfiler',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerMethodPropertySlot'
	],
	#category : 'Insight-Examples',
	#package : 'Insight-Examples'
}

{ #category : 'api' }
LineProfiler class >> measureCoverageOfMethods: aCollection during: aFullBlockClosure [

	^ self instrumentMethods: aCollection during: aFullBlockClosure
]

{ #category : 'as yet unclassified' }
LineProfiler >> afterStatement: statement at: index [

	coverage := coverage + 0.5
]

{ #category : 'as yet unclassified' }
LineProfiler >> beforeSequence: aSequence at: index [

	coverage := coverage + 1.0
]

{ #category : 'as yet unclassified' }
LineProfiler >> beforeStatement: statement at: index [

	coverage := coverage + 0.5
]

{ #category : 'default values' }
LineProfiler >> coverageDefaultValueForMethod: aCollection [ 
	
	^ Array new: 100 withAll: 0
]

{ #category : 'initialization' }
LineProfiler >> initialize_coverage: coverageBinding forMethod: aMethod [

	| coverageEntries |
	coverageEntries := aMethod ast allSequenceNodes sum: [ :e |
		                   e statements size + 1 ].
	coverageBinding value: (Array new: coverageEntries).
	^ coverageBinding
]
