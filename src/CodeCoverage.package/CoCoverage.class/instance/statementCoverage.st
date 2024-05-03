coverage
statementCoverage
	"All statements associated with their coverage."

	| coverages |
	coverages := Dictionary new.
	instrumentedMethods keysDo: [ :method |
		(Array new: 5 streamContents: [ :s |
			 method ast allSequenceNodes do: [ :sequence |
				 s nextPut: sequence.
				 s nextPutAll: sequence statements ] ])
			with: (self coverageOf: method)
			do: [ :statement :coverage | coverages at: statement put: coverage ] ].
	^ coverages