computation
partialPercentage

	| covered total |
	covered := 0.
	total := 0.
	instrumentedMethods keys collect: [ :method |
		| coverage |
		coverage := self coverageOf: method.
		covered := covered
		           +
		           (coverage count: [ :lineCoverage |
			            lineCoverage notNil ]).
		total := total + coverage size ].
	^ 100 * covered / total