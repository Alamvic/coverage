Class {
	#name : 'InPerMethodPropertyDeclaration',
	#superclass : 'InPropertyDeclaration',
	#instVars : [
		'binding'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'bindings' }
InPerMethodPropertyDeclaration >> methodBinding [

	binding ifNotNil: [ ^ binding ].
	^ binding := Array new: properties size withAll: defaultValue
]

{ #category : 'bindings' }
InPerMethodPropertyDeclaration >> methodBindings [

	^ { self methodBinding }
]

{ #category : 'codegen' }
InPerMethodPropertyDeclaration >> readNodeForProperty: anInProperty [

	^ RBMessageNode
		  receiver: (RBVariableNode named: self name)
		  selector: #at:
		  arguments: { (RBLiteralValueNode value: anInProperty index) }
]

{ #category : 'initialization' }
InPerMethodPropertyDeclaration >> setValueOf: anInProperty to: aValue [

	self methodBinding at: anInProperty index put: aValue
]

{ #category : 'writing' }
InPerMethodPropertyDeclaration >> writeNodeForProperty: anInProperty withValue: aRBLiteralValueNode [

	^ RBMessageNode
		  receiver: (RBVariableNode named: self name)
		  selector: #at:put:
		  arguments: {
				  (RBLiteralValueNode value: anInProperty index).
				  aRBLiteralValueNode }
]
