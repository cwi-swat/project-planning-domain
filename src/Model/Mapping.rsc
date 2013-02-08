module Model::Mapping

data ModelMapping
	= equalName(str sourceName, str targetName, str reason = "", bool correct = true)
	| synonym(str sourceName, str targetName, str reason = "", bool correct = true)
	| specialisation(str sourceName, str targetName, str reason = "")
	| specialisation(set[str] sourceNames, str targetName, str reason = "")
	| implementationDetail(str sourceName, str targetName, str reason = "")
	| mappedToRelation(str sourceName, str targetName, str relationName, str reason = "")
	;
	
data ModelMappingFailure
	= missing(str sourceName, str reason)
	| implementationDetail(str sourceName, str reason)
	| implementationDetail(set[str] sourceNames, str reason)
	| domainDetail(str sourceName, str reason)
	| domainDetail(set[str] sourceNames, str reason)
	;
	
alias ModelMappings = set[ModelMapping];
alias ModelMappingFailures = set[ModelMappingFailure];