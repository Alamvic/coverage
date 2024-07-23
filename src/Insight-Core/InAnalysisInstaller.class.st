Class {
	#name : 'InAnalysisInstaller',
	#superclass : 'Object',
	#instVars : [
		'analysis',
		'package'
	],
	#category : 'Insight-Core',
	#package : 'Insight-Core'
}

{ #category : 'accessing' }
InAnalysisInstaller >> analysis [

	^ analysis
]

{ #category : 'accessing' }
InAnalysisInstaller >> analysis: anObject [

	analysis := anObject
]

{ #category : 'accessing' }
InAnalysisInstaller >> package [

	^ package
]

{ #category : 'accessing' }
InAnalysisInstaller >> package: anObject [

	package := anObject
]
