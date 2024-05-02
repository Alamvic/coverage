tests
testInstrumentationOfBlocksValue

	| m return |
	m := self class >> #methodWithBlockReturningValue:.
	c instrument: m.
	
	return := self methodWithBlockReturningValue: true.

	self assert: return equals: 1