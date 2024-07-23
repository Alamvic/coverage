Class {
	#name : 'InAnalysisTest',
	#superclass : 'TestCase',
	#category : 'Insight-Tests',
	#package : 'Insight-Tests'
}

{ #category : 'tests' }
InAnalysisTest >> testAnalysisHasOneHook [

	| analysis something |
	analysis := InDynamicAnalysis new
		beforeStatement: [ :before | something := true ];
		yourself.

	self assert: analysis hooks size equals: 1
]

{ #category : 'tests' }
InAnalysisTest >> testNewAnalysisHasNoHooks [

	| analysis |
	analysis := InDynamicAnalysis new yourself.

	self assert: analysis hooks isEmpty
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodPropertyCreatesOneArray [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBinding size equals: 2
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodPropertyCreatesOneBinding [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBindings size equals: 1
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodPropertyDefaultValue [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBinding first equals: nil.
	self assert: declaration methodBinding second equals: nil
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodPropertyIsConnectedToBinding [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.
	
	property1 value: 17.

	self assert: declaration methodBinding first equals: 17.
	self assert: declaration methodBinding second equals: 0
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodPropertySetDefaultValue [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBinding first equals: 0.
	self assert: declaration methodBinding second equals: 0
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodReadCodeGeneration [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: property1 readNode equals: (RBMessageNode
			 receiver: (RBVariableNode named: #something)
			 selector: #at:
			 arguments: { (RBLiteralValueNode value: property1 index) })
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodSecondPropertyIsConnectedToBinding [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.
	
	property2 value: 17.

	self assert: declaration methodBinding first equals: 0.
	self assert: declaration methodBinding second equals: 17
]

{ #category : 'tests' }
InAnalysisTest >> testPerMethodWriteCodeGeneration [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerMethodPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self
		assert: (property1 writeNodeWithValueNode: (RBLiteralValueNode value: 17))
		equals: (RBMessageNode
				 receiver: (RBVariableNode named: #something)
				 selector: #at:put:
				 arguments: {
						 (RBLiteralValueNode value: property1 index).
						 (RBLiteralValueNode value: 17) })
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementPropertyCreatesManyBindings [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBindings size equals: 2
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementPropertyDefaultValue [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBindings first value equals: nil.
	self assert: declaration methodBindings second value equals: nil
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementPropertyIsConnectedToBinding [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.
	
	property1 value: 17.

	self assert: declaration methodBindings first value equals: 17.
	self assert: declaration methodBindings second value equals: 0
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementPropertySetDefaultValue [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self assert: declaration methodBindings first value equals: 0.
	self assert: declaration methodBindings second value equals: 0
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementReadCodeGeneration [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self
		assert: property1 readNode
		equals:
		(RBVariableNode named: 'something_' , property1 index asString)
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementSecondPropertyIsConnectedToBinding [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	declaration defaultValue: 0.
	property1 := declaration newProperty.
	property2 := declaration newProperty.
	
	property2 value: 17.

	self assert: declaration methodBindings first value equals: 0.
	self assert: declaration methodBindings second value equals: 17
]

{ #category : 'tests' }
InAnalysisTest >> testPerStatementWriteCodeGeneration [

	| analysis something declaration property1 property2 |
	analysis := InDynamicAnalysis new
		            beforeStatement: [ :before | something := true ];
		            declare: #something as: InPerStatementPropertySlot new;
		            yourself.

	declaration := analysis propertyDeclarationNamed: #something.
	property1 := declaration newProperty.
	property2 := declaration newProperty.

	self
		assert: (property1 writeNodeWithValueNode: (RBLiteralValueNode value: 17))
		equals: (RBAssignmentNode
				 variable: (RBVariableNode named: 'something_', property1 index asString)
				 value: (RBLiteralValueNode value: 17))
]
