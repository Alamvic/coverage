instrumenting
additionalBindings: instrumentation

	^ {
		  ('COUNTER_ENTRY' -> (Array new: instrumentation second withAll: 0)).
		  ('COUNTER_EXIT' -> (Array new: instrumentation second withAll: 0)) }