Class {
	#name : 'InPerStatementPropertyDeclaration',
	#superclass : 'InPropertyDeclaration',
	#instVars : [
		'binding'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'bindings' }
InPerStatementPropertyDeclaration >> methodBindings [

	binding ifNotNil: [ ^ binding ].
	^ binding := properties collect: [ :e |
		             AdditionalBinding
			             key: (self nameForProperty: e)
			             value: defaultValue ]
]

{ #category : 'codegen' }
InPerStatementPropertyDeclaration >> nameForProperty: anInProperty [

	^ self name , '_' , anInProperty index asString
]

{ #category : 'codegen' }
InPerStatementPropertyDeclaration >> readNodeForProperty: anInProperty [

	^ RBVariableNode named: (self nameForProperty: anInProperty)
]

{ #category : 'initialization' }
InPerStatementPropertyDeclaration >> setValueOf: anInProperty to: aValue [

	(self methodBindings at: anInProperty index) value: aValue
]

{ #category : 'writing' }
InPerStatementPropertyDeclaration >> writeNodeForProperty: anInProperty withValue: aValueNode [

	^ RBAssignmentNode
		  variable: (self readNodeForProperty: anInProperty)
		  value: aValueNode
]
