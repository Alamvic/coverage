Class {
	#name : 'InPropertyDeclaration',
	#superclass : 'Object',
	#instVars : [
		'name',
		'properties',
		'defaultValue'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessing' }
InPropertyDeclaration >> defaultValue: aValue [
	
	defaultValue := aValue
]

{ #category : 'accessing' }
InPropertyDeclaration >> indexOf: anInProperty [

	^ properties indexOf: anInProperty
]

{ #category : 'initialization' }
InPropertyDeclaration >> initialize [

	super initialize.
	properties := OrderedCollection new
]

{ #category : 'bindings' }
InPropertyDeclaration >> methodBindings [
	
	self subclassResponsibility
]

{ #category : 'accessing' }
InPropertyDeclaration >> name [

	^ name
]

{ #category : 'accessing' }
InPropertyDeclaration >> name: anObject [

	name := anObject
]

{ #category : 'instance creation' }
InPropertyDeclaration >> newProperty [

	| property |
	property := InProperty new
		            declaration: self;
		            yourself.
	properties add: property.
	^ property
]

{ #category : 'codegen' }
InPropertyDeclaration >> readNodeForProperty: anInProperty [

	self subclassResponsibility
]

{ #category : 'initialization' }
InPropertyDeclaration >> setValueOf: anInProperty to: anInteger [

	self subclassResponsibility
]

{ #category : 'writing' }
InPropertyDeclaration >> writeNodeForProperty: anInProperty withValue: aValueNode [

	self subclassResponsibility
]
