computation
methodPercentage

	| covered |
	covered := 0.
	instrumentedMethods keys collect: [ :method |
		| coverage |
		coverage := self coverageOf: method.
		covered := covered + coverage first notNil asBit ].
	^ 100 * covered / instrumentedMethods size