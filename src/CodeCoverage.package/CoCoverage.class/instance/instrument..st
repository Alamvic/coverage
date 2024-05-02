instrumenting
instrument: aMethod

	| ast newMethod instrumentation |
	instrumentation := self instrumentedCodeOf: aMethod.
	ast := instrumentation first.

	newMethod := OpalCompiler new
		             source: ast formattedCode;
		             class: aMethod methodClass;
		             bindings: (self additionalBindings: instrumentation);
		             compile;
		             install.

	instrumentedMethods at: aMethod put: newMethod.
	^ newMethod