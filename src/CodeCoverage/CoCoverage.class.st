Class {
	#name : 'CoCoverage',
	#superclass : 'InAnalysis',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'accessing' }
CoCoverage >> coverageOf: aMethod [

	| instrumentedMethod |
	instrumentedMethod := instrumentedMethods at: aMethod.
	^ (instrumentedMethod literals
		   detect: [ :e | e isKindOf: AdditionalBinding ]
		   ifNone: [ ^ #(  ) ]) value
]

{ #category : 'accessing' }
CoCoverage >> coveredMethods [
	
	^ instrumentedMethods keys select: [ :e | self isCoveredMethod: e ]
]

{ #category : 'testing' }
CoCoverage >> isCoveredMethod: aMethod [
	
	^ (self coverageOf: aMethod) first notNil
]

{ #category : 'coverage' }
CoCoverage >> methodCoverage [
	"All methods associated with their coverage."

	^ instrumentedMethods keys
		  collect: [ :method | method -> (self coverageOf: method) ]
		  as: Dictionary
]

{ #category : 'computation' }
CoCoverage >> methodPercentage [

	| covered |
	covered := 0.
	instrumentedMethods keys collect: [ :method |
		| coverage |
		coverage := self coverageOf: method.
		covered := covered + coverage first notNil asBit ].
	^ 100 * covered / instrumentedMethods size
]

{ #category : 'computation' }
CoCoverage >> partialPercentage [

	| covered total |
	covered := 0.
	total := 0.
	instrumentedMethods keys collect: [ :method |
		| coverage |
		coverage := self coverageOf: method.
		covered := covered
		           +
		           (coverage count: [ :lineCoverage |
			            lineCoverage notNil ]).
		total := total + coverage size ].
	^ 100 * covered / total
]

{ #category : 'computation' }
CoCoverage >> percentage [

	| covered total |
	covered := 0.
	total := 0.
	instrumentedMethods keys collect: [ :method |
		| coverage |
		coverage := self coverageOf: method.
		covered := covered
		           +
		           (coverage count: [ :lineCoverage |
			            lineCoverage = #complete ]).
		total := total + coverage size ].
	^ 100 * covered / total
]

{ #category : 'dependencies' }
CoCoverage >> release [

	instrumentedMethods keys do: [ :e |
		e methodClass methodDictionary at: e selector put: e ]
]

{ #category : 'coverage' }
CoCoverage >> statementCoverage [
	"All statements associated with their coverage."

	| coverages |
	coverages := Dictionary new.
	instrumentedMethods keysDo: [ :method |
		(Array new: 5 streamContents: [ :s |
			 method ast allSequenceNodes do: [ :sequence |
				 s nextPut: sequence.
				 s nextPutAll: sequence statements ] ])
			with: (self coverageOf: method)
			do: [ :statement :coverage | coverages at: statement put: coverage ] ].
	^ coverages
]
