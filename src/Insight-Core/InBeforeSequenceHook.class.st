Class {
	#name : 'InBeforeSequenceHook',
	#superclass : 'InHook',
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessig' }
InBeforeSequenceHook class >> hookSelector [
	
	^ #beforeSequence:at: 
]

{ #category : 'accessing' }
InBeforeSequenceHook >> additionalBindingsForProperty: aProperty inMethod: aMethod withinAnalysis: anAnalysis [

	^ aMethod ast allSequenceNodes collectWithIndex: [ :seq :index |
		  aProperty bindingBeforeSequence: index ]
]
