Class {
	#name : 'InAnalysis',
	#superclass : 'Object',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'api' }
InAnalysis class >> instrumentMethods: aCollection during: aFullBlockClosure [ 
	
	| coverage |
	coverage := self new.
	aCollection do: [ :m | coverage instrument: m ].
	aFullBlockClosure ensure: [ 
		coverage release ].
	^ coverage
]

{ #category : 'instrumenting' }
InAnalysis >> additionalBindings: aMethod [

	^ self class slots flatCollect: [ :s |
		  (s isKindOf: InSlot) ifTrue: [
			  s additionalBindingsForMethod: aMethod ] ]
]

{ #category : 'instrumenting' }
InAnalysis >> afterStatement: statement at: index [

	"Empty"
]

{ #category : 'instrumenting' }
InAnalysis >> beforeMethod: aMethod [

	"Empty"
]

{ #category : 'instrumenting' }
InAnalysis >> beforeSequence: aSequence at: anIndex [

	"Empty"
]

{ #category : 'instrumenting' }
InAnalysis >> beforeStatement: statement at: index [

	"Empty"
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentBeforeSequence: sequenceNode at: sequenceIndex [

	| replacementNodes before |
	replacementNodes := OrderedCollection new.
	before := self instrumentationNodeBeforeSequence: sequenceNode atIndex: sequenceIndex.

	before ifNotNil: [ sequenceNode addNodeFirst: before ]
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentStatement: s at: index [

	| expressionValue statementValue replacementNodes parent before after |
	expressionValue := '____xpval'.
	parent := s parent.
	(parent temporaryNames includes: expressionValue)
		ifFalse: [ parent addTemporaryNamed: expressionValue ].

	statementValue := s isReturn
		                  ifTrue: [ s value ]
		                  ifFalse: [ s ].

	replacementNodes := OrderedCollection new.
	before := self instrumentationNodeBeforeStatement: s atIndex: index.
	after := self instrumentationNodeAfterStatement: s atIndex: index.

	before ifNotNil: [ replacementNodes add: before ].
	replacementNodes add: (RBAssignmentNode
			 variable: (RBVariableNode named: expressionValue)
			 value: statementValue).
	after ifNotNil: [ replacementNodes add: after ].

	s isReturn
		ifTrue: [
			replacementNodes add:
				(RBReturnNode value: (RBVariableNode named: expressionValue)) ]
		ifFalse: [
		replacementNodes add: (RBVariableNode named: expressionValue) ].

	parent replaceNode: s withNodes: replacementNodes
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentationNodeAfterStatement: s atIndex: index [

	^ self
		  instrumentationNodeForStatement: s
		  atIndex: index
		  usingHook: #afterStatement:at:
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentationNodeBeforeSequence: aSequence atIndex: index [

	^ self
		  instrumentationNodeForStatement: aSequence
		  atIndex: index
		  usingHook: #beforeSequence:at:
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentationNodeBeforeStatement: s atIndex: index [

	^ self
		  instrumentationNodeForStatement: s
		  atIndex: index
		  usingHook: #beforeStatement:at:
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentationNodeForStatement: s atIndex: index usingHook: aStatementHook [
	"self newPartialCoverageStatementAt: index"

	^ self
		  instrumentationNodeUsingHook: aStatementHook
		  mappingVariableRewritesUsing: [ :e :hookMethod :replacements |
			  e isVariable ifTrue: [
				  e name = hookMethod argumentNames first
					  ifTrue: [ replacements at: e put: (RBLiteralNode value: s) ]
					  ifFalse: [
						  e name = hookMethod argumentNames second
							  ifTrue: [
							  replacements at: e put: (RBLiteralNode value: index) ]
							  ifFalse: [
								  self class
									  slotNamed: e name
									  ifFound: [ :slot |
										  (slot isKindOf: InSlot)
											  ifTrue: [ "Halt if the name introduces a conflict!"
												  self haltIf: [
													  s methodNode allDefinedVariables anySatisfy: [ :dv |
														  dv = slot name ] ].
												  self haltIf: [
													  s methodNode methodClass allSlots anySatisfy: [ :ds |
														  ds name = slot name ] ].
												  replacements
													  at: e
													  put:
													  (RBVariableNode named: (slot nameForStatementAt: index)) ]
											  ifFalse: [
											  self halt "Ok, we have a slot but not of good type" ] ]
									  ifNone: [ "Ok, we have a variable that is not a slot.
				Maybe a pseudo variable, a temp or global?"
										  self halt ] ] ] ] ]
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentationNodeUsingHook: aHook mappingVariableRewritesUsing: map [
	"self newPartialCoverageStatementAt: index"

	| hookMethod ast statementCopy replacements |
	hookMethod := self class lookupSelector: aHook.
	ast := hookMethod ast.
	ast statements ifEmpty: [ ^ nil ].

	"More than two statements or a return require a different translation!"
	ast statements size > 1 ifTrue: [ self halt ].
	ast statements first isReturn ifTrue: [ self halt ].

	"We need to expand parameters
	  - statement
	  - index
	  - and all declared instance variables"
	statementCopy := ast statements first copy.
	replacements := IdentityDictionary new.
	statementCopy nodesDo: [ :e |
		map value: e value: hookMethod value: replacements ].
	replacements keysAndValuesDo: [ :node :replacement |
		node parent replaceNode: node withNode: replacement ].
	^ statementCopy
]

{ #category : 'instrumenting' }
InAnalysis >> instrumentedCodeOfMethod: aMethod [

	| ast numberOfStatements sequences |
	ast := aMethod parseTree.

	"We have 1 more fake statement representing the start of the sequence block"
	sequences := ast allSequenceNodes.
	numberOfStatements := 0.
	sequences do: [ :sequenceNode |
		| statements sequenceIndex |
		sequenceIndex := numberOfStatements := numberOfStatements + 1.
		statements := sequenceNode statements.
		statements withIndexDo: [ :s :i |
			numberOfStatements := numberOfStatements + 1.
			self instrumentStatement: s at: numberOfStatements ].
		self instrumentBeforeSequence: sequenceNode at: sequenceIndex ].

	^ {
		  ast formattedCode.
		  numberOfStatements }
]
