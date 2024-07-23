Class {
	#name : 'InBeforeStatementHook',
	#superclass : 'InHook',
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessig' }
InBeforeStatementHook class >> hookSelector [

	^ #beforeStatement:at:
]
