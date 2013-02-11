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
	| domainDetail(str sourceName, str reason)
	| tooDetailed(str sourceName, str reason)
	| differentDesign(str sourceName, str reason)
	;
	
public ModelMappingFailure missing(set[str] sourceName) = missing(sourceName, "");	

public set[ModelMappingFailure] missing(set[str] sourceNames, str reason) 
	= {missing(n, reason) | n <- sourceNames};
public set[ModelMappingFailure] implementationDetail(set[str] sourceNames, str reason)
	= {implementationDetail(n, reason) | n <- sourceNames};
public set[ModelMappingFailure] domainDetail(set[str] sourceNames, str reason)
	= {domainDetail(n, reason) | n <- sourceNames};
public set[ModelMappingFailure] differentDesign(set[str] sourceNames, str reason)
	= {differentDesign(n, reason) | n <- sourceNames};

	
alias ModelMappings = set[ModelMapping];
alias ModelMappingFailures = set[ModelMappingFailure];

public anno ModelMappings ModelMapping@attrs;
public anno ModelMappingFailures ModelMapping@missingAttr;