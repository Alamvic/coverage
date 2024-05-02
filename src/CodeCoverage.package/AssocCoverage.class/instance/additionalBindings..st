instrumenting
additionalBindings: instrumentation

	| bindings |
	bindings := (1 to: instrumentation second) collect: [ :i |
		            AdditionalBinding
			            key: ('COVERAGE_' , i asString) asSymbol
			            value: Association new ].

	^ bindings