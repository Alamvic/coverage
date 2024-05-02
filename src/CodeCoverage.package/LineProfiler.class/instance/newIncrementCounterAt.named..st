instrumenting
newIncrementCounterAt: index named: varName
	"COUNTER_EXIT[X] at: index put: ((COUNTER_EXIT at: index) + 1)"

	| read inc |
	read := RBMessageNode
		        receiver: (RBVariableNode named: varName)
		        selector: #at:
		        arguments: { (RBLiteralNode value: index) }.
	inc := RBMessageNode
		       receiver: read
		       selector: #+
		       arguments: { (RBLiteralNode value: 1) }.
	^ RBMessageNode
		  receiver: (RBVariableNode named: varName)
		  selector: #at:put:
		  arguments: {
				  (RBLiteralNode value: index).
				  inc }