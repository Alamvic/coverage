instrumenting
newCoverageStatementAt: index value: value

	^ RBMessageNode
		  receiver: (RBVariableNode named: 'COVERAGE')
		  selector: #at:put:
		  arguments: {
				  (RBLiteralNode value: index).
				  (RBLiteralNode value: value) }