Class {
	#name : 'LineProfiler',
	#superclass : 'LineCoverage',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'instrumenting' }
LineProfiler >> additionalBindings: instrumentation [

	^ {
		  ('COUNTER_ENTRY' -> (Array new: instrumentation second withAll: 0)).
		  ('COUNTER_EXIT' -> (Array new: instrumentation second withAll: 0)) }
]

{ #category : 'instrumenting' }
LineProfiler >> newCompleteCoverageStatementAt: index [

	^ self newIncrementCounterAt: index named: 'COUNTER_EXIT'
]

{ #category : 'instrumenting' }
LineProfiler >> newIncrementCounterAt: index named: varName [
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
]

{ #category : 'instrumenting' }
LineProfiler >> newPartialCoverageStatementAt: index [

	^ self newIncrementCounterAt: index named: 'COUNTER_ENTRY'
]
