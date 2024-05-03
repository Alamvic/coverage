tests
testMethodCoverage

	| m coverage |
	m := self class >> #linearMethod.
	c instrument: m.

	self linearMethod.

	coverage := c methodCoverage.
	self assert: coverage size equals: 1.
	self assert: coverage keys first equals: m.
	self assert:
		(coverage values first allSatisfy: [ :e | e = #complete ])