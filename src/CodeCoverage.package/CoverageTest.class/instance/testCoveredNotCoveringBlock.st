tests
testCoveredNotCoveringBlock

	| m |
	m := self class >> #methodWithBlock:.
	c instrument: m.

	self methodWithBlock: false.

	self assert: ((c coverageOf: m) count: [ :e | e = #complete ]) equals: 3