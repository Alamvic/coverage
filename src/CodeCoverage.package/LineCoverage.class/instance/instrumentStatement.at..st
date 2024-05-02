instrumenting
instrumentStatement: s at: index

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