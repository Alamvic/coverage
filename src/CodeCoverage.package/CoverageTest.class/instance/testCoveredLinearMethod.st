tests
testCoveredLinearMethod

	| m |
	m := self class >> #linearMethod.
	c instrument: m.

	self linearMethod.

	self assert: ((c coverageOf: m) allSatisfy: [ :e | e = #complete ])