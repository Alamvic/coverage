tests
testNotCoveredEmptyBlock

	| m |
	m := self class >> #emptyBlock:.
	c instrument: m.

	self assert: (c coverageOf: m) second isNil