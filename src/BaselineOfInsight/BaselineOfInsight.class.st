Class {
	#name : 'BaselineOfInsight',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfInsight',
	#package : 'BaselineOfInsight'
}

{ #category : 'baselines' }
BaselineOfInsight >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'Insight-Core'.
		spec package: 'Insight-Examples' with: [ spec requires: #('Insight-Core') ].
		spec package: 'Insight-Tests' with: [ spec requires: #('Insight-Core' 'Insight-Examples') ].

		spec
			group: 'core' with: #( 'Insight-Tests' );
			group: 'default' with: #( 'core' ) ]
]
