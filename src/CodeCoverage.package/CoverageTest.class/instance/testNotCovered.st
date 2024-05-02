tests
testNotCovered

	| m |
	m := (self class >> #linearMethod).
	c instrument: m.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e isNil ])