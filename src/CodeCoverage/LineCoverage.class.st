Class {
	#name : 'LineCoverage',
	#superclass : 'CoCoverage',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'api' }
LineCoverage class >> measureCoverageOfMethods: aCollection during: aFullBlockClosure [ 
	
	| coverage |
	coverage := self new.
	aCollection do: [ :m | coverage instrument: m ].
	aFullBlockClosure ensure: [ 
		coverage release ].
	^ coverage
]

{ #category : 'instrumenting' }
LineCoverage >> instrumentStatement: s at: index [

	| expressionValue statementValue replacementNodes parent |
	expressionValue := '____xpval'.
	parent := s parent.
	parent addTemporaryNamed: expressionValue.

	statementValue := s isReturn
		                  ifTrue: [ s value ]
		                  ifFalse: [ s ].

	replacementNodes := OrderedCollection withAll: {
			                    (self newPartialCoverageStatementAt: index).
			                    (RBAssignmentNode
				                     variable:
				                     (RBVariableNode named: expressionValue)
				                     value: statementValue).
			                    (self newCompleteCoverageStatementAt: index) }.
	s isReturn
		ifTrue: [
			replacementNodes add:
				(RBReturnNode value: (RBVariableNode named: expressionValue)) ]
		ifFalse: [ replacementNodes add: (RBVariableNode named: expressionValue) ].

	parent replaceNode: s withNodes: replacementNodes
]

{ #category : 'instrumenting' }
LineCoverage >> instrumentedCodeOf: aMethod [

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
]
