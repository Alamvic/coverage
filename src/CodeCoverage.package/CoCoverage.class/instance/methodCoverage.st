coverage
methodCoverage
	"All methods associated with their coverage."

	^ instrumentedMethods keys
		  collect: [ :method | method -> (self coverageOf: method) ]
		  as: Dictionary