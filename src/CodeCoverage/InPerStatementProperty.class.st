Class {
	#name : 'InPerStatementProperty',
	#superclass : 'InSlot',
	#category : 'CodeCoverage',
	#package : 'CodeCoverage'
}

{ #category : 'accessing' }
InPerStatementProperty >> nameForStatementAt: anInteger [ 
	
	^ name, '_', anInteger asString
]
