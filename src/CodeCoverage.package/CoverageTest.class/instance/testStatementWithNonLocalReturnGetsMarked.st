tests
testStatementWithNonLocalReturnGetsMarked

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