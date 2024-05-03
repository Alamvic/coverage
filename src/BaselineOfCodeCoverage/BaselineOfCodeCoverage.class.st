Class {
	#name : 'BaselineOfCodeCoverage',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCodeCoverage',
	#package : 'BaselineOfCodeCoverage'
}

{ #category : 'baselines' }
BaselineOfCodeCoverage >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'CodeCoverage'.

		spec
			group: 'core' with: #( 'CodeCoverage' );
			group: 'default' with: #( 'core' ) ]
]
