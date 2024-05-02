tests
testCoveredEmptyMethod

	| m |
	m := self class >> #emptyMethod.
	c instrument: m.

	self emptyMethod.

	self assert: (c coverageOf: m) first equals: #complete