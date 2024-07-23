Class {
	#name : 'InHook',
	#superclass : 'Object',
	#instVars : [
		'analysis',
		'code'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessig' }
InHook class >> hookSelector [

	self subclassResponsibility
]

{ #category : 'testing' }
InHook class >> isDefinedIn: anAnalysis [

	| hookMethod ast |
	hookMethod := anAnalysis class lookupSelector: self hookSelector.
	ast := hookMethod ast.
	^ ast statements notEmpty
]

{ #category : 'accessing' }
InHook >> additionalBindingsForProperty: aProperty inMethod: aMethod withinAnalysis: anAnalysis [
	
	self subclassResponsibility
]

{ #category : 'accessing' }
InHook >> analysis: anAnalysis [

	analysis := anAnalysis
]

{ #category : 'accessing' }
InHook >> code: aCodeObject [

	code := aCodeObject
]
