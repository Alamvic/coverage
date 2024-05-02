dependencies
release

	instrumentedMethods keys do: [ :e |
		e methodClass methodDictionary at: e selector put: e ]