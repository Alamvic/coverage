baselines
baseline: spec

	<baseline>
	spec for: #common do: [
		spec package: 'CodeCoverage'.

		spec
			group: 'core' with: #( 'CodeCoverage' );
			group: 'default' with: #( 'core' ) ]