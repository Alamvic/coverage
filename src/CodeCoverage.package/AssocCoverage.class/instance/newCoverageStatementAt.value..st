instrumenting
newCoverageStatementAt: index value: value

	^ RBMessageNode
		  receiver: (RBVariableNode named: ('COVERAGE_' , index asString) asSymbol)
		  selector: #value:
		  arguments: { (RBLiteralNode value: value) }