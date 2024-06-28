Class {
	#name : 'LineCoverage',
	#superclass : 'CoCoverage',
	#instVars : [
		'#coverage => InPerMethodProperty'
	],
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'api' }
LineCoverage class >> measureCoverageOfMethods: aCollection during: aFullBlockClosure [

	^ self instrumentMethods: aCollection during: aFullBlockClosure
]

{ #category : 'as yet unclassified' }
LineCoverage >> afterStatement: statement at: index [

	coverage at: index put: #complete
]

{ #category : 'as yet unclassified' }
LineCoverage >> beforeSequence: aSequence at: anIndex [

	coverage at: anIndex put: #complete
]

{ #category : 'as yet unclassified' }
LineCoverage >> beforeStatement: statement at: index [

	coverage at: index put: #partial
]

{ #category : 'initialization' }
LineCoverage >> initialize_coverage: coverageBinding forMethod: aMethod [

	| coverageEntries |
	coverageEntries := aMethod ast allSequenceNodes sum: [ :e |
		                   e statements size + 1 ].
	coverageBinding value: (Array new: coverageEntries).
	^ coverageBinding
]
