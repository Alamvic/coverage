tests
testCoveredLinearMethodWithReturn

	| m |
	m := self class >> #linearMethodWithReturn.
	c instrument: m.

	self linearMethodWithReturn.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])