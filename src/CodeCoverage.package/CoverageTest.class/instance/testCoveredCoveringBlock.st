tests
testCoveredCoveringBlock

	| m |
	m := self class >> #methodWithBlock:.
	c instrument: m.

	self methodWithBlock: true.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])