Class {
	#name : 'InPerStatementPropertySlot',
	#superclass : 'InSlot',
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'binding creation' }
InPerStatementPropertySlot >> additionalBindingsForMethod: aMethod forAnalysis: anAnalysis [
	"I'm a per statement property, compute all necessary statements and create a binding per each"

	| defaultValue bindings |
	defaultValue := anAnalysis
		                perform: self name , #DefaultValueForMethod:
		                with: aMethod.

	bindings := anAnalysis properties flatCollect: #methodBindings.
	bindings do: [ :e | e value: defaultValue ].
	^ bindings
]

{ #category : 'accessing' }
InPerStatementPropertySlot >> nameForStatementAt: anInteger [ 
	
	^ name, '_', anInteger asString
]

{ #category : 'instance creation' }
InPerStatementPropertySlot >> newPropertyDeclarationNamed: aName [

	^ InPerStatementPropertyDeclaration new
		  name: aName;
		  yourself
]
