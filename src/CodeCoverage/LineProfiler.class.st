Class {
	#name : 'LineProfiler',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerMethodProperty'
	],
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'api' }
LineProfiler class >> measureCoverageOfMethods: aCollection during: aFullBlockClosure [

	^ self instrumentMethods: aCollection during: aFullBlockClosure
]

{ #category : 'as yet unclassified' }
LineProfiler >> afterStatement: statement at: index [

	coverage at: index put: (coverage at: index) + 0.5
]

{ #category : 'as yet unclassified' }
LineProfiler >> beforeSequence: aSequence at: index [

	coverage at: index put: (coverage at: index) + 1.0
]

{ #category : 'as yet unclassified' }
LineProfiler >> beforeStatement: statement at: index [

	coverage at: index put: (coverage at: index) + 0.5
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
