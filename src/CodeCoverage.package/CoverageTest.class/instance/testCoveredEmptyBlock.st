tests
testCoveredEmptyBlock

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