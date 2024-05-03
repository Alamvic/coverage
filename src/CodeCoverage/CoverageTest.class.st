Class {
	#name : 'CoverageTest',
	#superclass : 'TestCase',
	#instVars : [
		'c'
	],
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'tests' }
CoverageTest >> emptyBlock: arg [
	"Empty block on purpose to test the coverage of blocks with no statements"

	arg ifTrue: [  ]
]

{ #category : 'tests' }
CoverageTest >> emptyMethod [

	"Empty on purpose to test the coverage of methods with no statements"
]

{ #category : 'tests' }
CoverageTest >> linearMethod [

	1 + 1.
	1 + 2.

]

{ #category : 'tests' }
CoverageTest >> linearMethodWithReturn [

	1 + 1.
	1 + 2.
	^ 17
]

{ #category : 'tests' }
CoverageTest >> methodWithBlock: arg [

	arg ifTrue: [ 1 ].
	^ 2
]

{ #category : 'tests' }
CoverageTest >> methodWithBlockNonLocalReturn: arg [

	arg ifTrue: [ ^ 1 ].
	^ 2
]

{ #category : 'tests' }
CoverageTest >> methodWithBlockReturningValue: arg [

	^ arg ifTrue: [ 1 ] ifFalse: [ 2 ]
]

{ #category : 'tests' }
CoverageTest >> setUp [

	super setUp.
	c := LineCoverage new
]

{ #category : 'tests' }
CoverageTest >> tearDown [

	c release.
	super tearDown.
]

{ #category : 'tests' }
CoverageTest >> testCoveredCoveringBlock [

	| m |
	m := self class >> #methodWithBlock:.
	c instrument: m.

	self methodWithBlock: true.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])
]

{ #category : 'tests' }
CoverageTest >> testCoveredEmptyBlock [

	| m |
	m := self class >> #emptyBlock:.
	c instrument: m.
	
	self emptyBlock: true.

	"Should have 3 markers
	Start of method
	arg ifTrue: [ ... ]
	Start of block (inside the ifTrue)"
	self assert: (c coverageOf: m) size equals: 3.
	self assert: (c coverageOf: m) third equals: #complete
]

{ #category : 'tests' }
CoverageTest >> testCoveredEmptyMethod [

	| m |
	m := self class >> #emptyMethod.
	c instrument: m.

	self emptyMethod.

	self assert: (c coverageOf: m) first equals: #complete
]

{ #category : 'tests' }
CoverageTest >> testCoveredLinearMethod [

	| m |
	m := self class >> #linearMethod.
	c instrument: m.

	self linearMethod.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])
]

{ #category : 'tests' }
CoverageTest >> testCoveredLinearMethodWithReturn [

	| m |
	m := self class >> #linearMethodWithReturn.
	c instrument: m.

	self linearMethodWithReturn.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])
]

{ #category : 'tests' }
CoverageTest >> testCoveredNotCoveringBlock [

	| m |
	m := self class >> #methodWithBlock:.
	c instrument: m.

	self methodWithBlock: false.

	self assert: ((c coverageOf: m) count: [ :e | e = #complete ]) equals: 3
]

{ #category : 'tests' }
CoverageTest >> testInstrumentationOfBlocks [

	| m |
	m := self class >> #methodWithBlock:.
	c instrument: m.

	"Should instrument 5 markers:
	
	- start of method
	- if statement
	- start of block
	- block statement
	- statement after conditional
	"
	self assert: (c coverageOf: m) size equals: 5
]

{ #category : 'tests' }
CoverageTest >> testInstrumentationOfBlocksValue [

	| m return |
	m := self class >> #methodWithBlockReturningValue:.
	c instrument: m.
	
	return := self methodWithBlockReturningValue: true.

	self assert: return equals: 1
]

{ #category : 'tests' }
CoverageTest >> testMethodCoverage [

	| m coverage |
	m := self class >> #linearMethod.
	c instrument: m.

	self linearMethod.

	coverage := c methodCoverage.
	self assert: coverage size equals: 1.
	self assert: coverage keys first equals: m.
	self assert:
		(coverage values first allSatisfy: [ :e | e = #complete ])
]

{ #category : 'tests' }
CoverageTest >> testNotCovered [

	| m |
	m := (self class >> #linearMethod).
	c instrument: m.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e isNil ])
]

{ #category : 'tests' }
CoverageTest >> testNotCoveredEmptyBlock [

	| m |
	m := self class >> #emptyBlock:.
	c instrument: m.

	self assert: (c coverageOf: m) second isNil
]

{ #category : 'tests' }
CoverageTest >> testNotCoveredEmptyMethod [

	| m |
	m := self class >> #emptyMethod.
	c instrument: m.

	self assert: (c coverageOf: m) first isNil
]

{ #category : 'tests' }
CoverageTest >> testStatementCoverage [

	| m coverage |
	m := self class >> #linearMethod.
	c instrument: m.

	self linearMethod.

	coverage := c statementCoverage.
	self assert: coverage size equals: 3.
	self
		assertCollection: coverage keys
		hasSameElements: (m ast allSequenceNodes flatCollect: [ :s |
				 Array with: s withAll: s statements ]).
	self assert: (coverage values allSatisfy: [ :e | e = #complete ]) 
]

{ #category : 'tests' }
CoverageTest >> testStatementWithNonLocalReturnGetsMarked [

	| m |
	m := self class >> #methodWithBlockNonLocalReturn:.
	c instrument: m.
	
	self methodWithBlockNonLocalReturn: true.

	"Should instrument, in order:
	
	start of method
	if statement
	statement after if
	start of block
	statement in block
	"
	self assert: (c coverageOf: m) second equals: #partial
]

{ #category : 'tests' }
CoverageTest >> testStatementWithNotExecutedNonLocalReturnGetsMarked [

	| m |
	m := self class >> #methodWithBlockNonLocalReturn:.
	c instrument: m.
	
	self methodWithBlockNonLocalReturn: false.

	self assert: (c coverageOf: m) second equals: #complete
]
