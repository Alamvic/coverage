Class {
	#name : 'CoCoverage',
	#superclass : 'Object',
	#instVars : [
		'instrumentedMethods'
	],
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'instrumenting' }
CoCoverage >> additionalBindings: instrumentation [

	^ { ('COVERAGE' -> (Array new: instrumentation second)) }
]

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

{ #category : 'instrumenting' }
CoCoverage >> initialize [

	super initialize.
	instrumentedMethods := Dictionary new
]

{ #category : 'instrumenting' }
CoCoverage >> instrument: aMethod [

	| ast newMethod instrumentation |
	instrumentation := self instrumentedCodeOf: aMethod.
	ast := instrumentation first.

	newMethod := OpalCompiler new
		             source: ast formattedCode;
		             class: aMethod methodClass;
		             bindings: (self additionalBindings: instrumentation);
		             compile;
		             install.

	instrumentedMethods at: aMethod put: newMethod.
	^ newMethod
]

{ #category : 'testing' }
CoCoverage >> isCoveredMethod: aMethod [
	
	^ (self coverageOf: aMethod) first notNil
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

{ #category : 'instrumenting' }
CoCoverage >> newCompleteCoverageStatementAt: index [

	^ self newCoverageStatementAt: index value: #complete
]

{ #category : 'instrumenting' }
CoCoverage >> newCoverageStatementAt: index value: value [

	^ RBMessageNode
		  receiver: (RBVariableNode named: 'COVERAGE')
		  selector: #at:put:
		  arguments: {
				  (RBLiteralNode value: index).
				  (RBLiteralNode value: value) }
]

{ #category : 'instrumenting' }
CoCoverage >> newPartialCoverageStatementAt: index [

	^ self newCoverageStatementAt: index value: #partial
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
