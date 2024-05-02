tests
testNotCoveredEmptyMethod

	| m |
	m := self class >> #emptyMethod.
	c instrument: m.

	self assert: (c coverageOf: m) first isNil