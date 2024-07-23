Class {
	#name : 'InPerMethodPropertySlot',
	#superclass : 'InSlot',
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'binding creation' }
InPerMethodPropertySlot >> additionalBindingsForMethod: aMethod forAnalysis: anAnalysis [
	"I'm a per method property, just return a single binding"

	| defaultValue |
	defaultValue := anAnalysis
		                perform: self name , #DefaultValueForMethod:
		                with: aMethod.
	^ { (self name -> defaultValue) }
]

{ #category : 'accessing' }
InPerMethodPropertySlot >> nameForStatementAt: anInteger [ 
	
	^ name
]

{ #category : 'instance creation' }
InPerMethodPropertySlot >> newPropertyDeclarationNamed: aName [

	^ InPerMethodPropertyDeclaration new
		  name: aName;
		  yourself
]
