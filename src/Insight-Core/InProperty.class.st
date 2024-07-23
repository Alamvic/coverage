Class {
	#name : 'InProperty',
	#superclass : 'Object',
	#instVars : [
		'declaration'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessing' }
InProperty >> declaration [

	^ declaration
]

{ #category : 'accessing' }
InProperty >> declaration: anObject [

	declaration := anObject
]

{ #category : 'accessing' }
InProperty >> index [

	^ declaration indexOf: self
]

{ #category : 'code-gen' }
InProperty >> readNode [

	^ declaration readNodeForProperty: self
]

{ #category : 'accessing' }
InProperty >> value: aValue [

	declaration setValueOf: self to: aValue
]

{ #category : 'writing' }
InProperty >> writeNodeWithValueNode: aValueNode [

	^ declaration writeNodeForProperty: self withValue: aValueNode
]
