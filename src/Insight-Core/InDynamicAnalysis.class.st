Class {
	#name : 'InDynamicAnalysis',
	#superclass : 'InAnalysis',
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessing' }
InDynamicAnalysis >> beforeStatement: aFullBlockClosure [

	hooks add: (InBeforeStatementHook new
			 analysis: self;
			 code: aFullBlockClosure;
			 yourself)
]

{ #category : 'initialization' }
InDynamicAnalysis >> initialize [

	super initialize.
	hooks := OrderedCollection new
]
