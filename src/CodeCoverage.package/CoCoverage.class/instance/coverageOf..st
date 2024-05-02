accessing
coverageOf: aMethod

	| instrumentedMethod |
	instrumentedMethod := instrumentedMethods at: aMethod.
	^ (instrumentedMethod literals
		   detect: [ :e | e isKindOf: AdditionalBinding ]
		   ifNone: [ ^ #(  ) ]) value