tests
testStatementCoverage

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