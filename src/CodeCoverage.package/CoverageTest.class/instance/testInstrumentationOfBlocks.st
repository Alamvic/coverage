tests
testInstrumentationOfBlocks

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