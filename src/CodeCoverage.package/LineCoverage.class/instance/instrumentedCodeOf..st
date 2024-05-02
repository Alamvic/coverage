instrumenting
instrumentedCodeOf: aMethod

	| ast numberOfStatements sequences |
	ast := aMethod parseTree.

	"We have 1 more fake statement representing the start of the sequence block"
	sequences := ast allSequenceNodes.
	numberOfStatements := 0.
	sequences do: [ :sequenceNode |
		| statements sequenceIndex |
		sequenceIndex := (numberOfStatements := numberOfStatements + 1). 
		statements := sequenceNode statements.
		statements withIndexDo: [ :s :i |
			numberOfStatements := numberOfStatements + 1.
			self instrumentStatement: s at: numberOfStatements ].
		sequenceNode addNodeFirst:
			(self newCompleteCoverageStatementAt: sequenceIndex) ].

	^ {
		  ast formattedCode.
		  numberOfStatements }