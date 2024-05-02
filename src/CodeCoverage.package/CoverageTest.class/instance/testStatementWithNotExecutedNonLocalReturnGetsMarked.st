tests
testStatementWithNotExecutedNonLocalReturnGetsMarked

	| m |
	m := self class >> #methodWithBlockNonLocalReturn:.
	c instrument: m.
	
	self methodWithBlockNonLocalReturn: false.

	self assert: (c coverageOf: m) second equals: #complete