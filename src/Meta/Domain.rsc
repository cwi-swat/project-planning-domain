module Meta::Domain


// domain model

alias DomainModel = set[Class];

data Class 
	= class(str name, list[Attribute] attributes, list[Association] assocations)
	| specialisation(str name, str baseClass, list[Attribute] attributes, list[Association] assocations)
	;
	
data Attribute = attr(str name);
data Association = asso(str label, str otherClass);

anno str Association@class;
anno set[str] Class@alternativeNames;


// Glossary

data DictionaryWord = term(str name, set[int] descriptions);
alias Dictionary = set[DictionaryWord];

// Process

data Behavior 
	= actorActivity(str input, str name, str activity, str entity)
	| processActivity(str input, str name, str activity, str entity)
	| composedOutOf(str input, str entity, set[str] sourceEntities)
	;

// traceability
anno set[int] Class@source;
anno set[int] Attribute@source;
anno set[int] Association@source;

anno set[loc] Class@location;
anno set[loc] Attribute@location;
anno set[loc] Association@location;

anno set[str] Class@uiscreen;
anno set[str] Attribute@uiscreen;
anno set[str] Association@uiscreen;

anno set[int] Behavior@source;


// with newer version of rascal, we would have used optional arguments feature
public Class class(str name) = class(name, [],[]);
public Class class(str name, set[int] source) = class(name)[@source = source];
public Class class(str name, list[Attribute] attributes) = class(name, attributes, []);
public Class class(str name, list[Attribute] attributes, set[int] source) = class(name, attributes)[@source = source];
public Class class(str name, list[Attribute] attributes, list[Association] assocations, set[int] source) = class(name, attributes, assocations)[@source = source];

public Class specialisation(str name, str baseClass) = specialisation(name, baseClass, [],[]);
public Class specialisation(str name, str baseClass, set[int] source) = specialisation(name, baseClass)[@source = source];
public Class specialisation(str name, str baseClass, list[Attribute] attributes) = specialisation(name, baseClass, attributes, []);
public Class specialisation(str name, str baseClass, list[Attribute] attributes, set[int] source) = specialisation(name, baseClass, attributes)[@source = source];
public Class specialisation(str name, str baseClass, list[Attribute] attributes, list[Association] assocations, set[int] source) = specialisation(name, baseClass, attributes, assocations)[@source = source];

public Class class(str name, list[Attribute] attributes, loc location) = class(name, attributes, [], location); 
public Class class(str name, list[Attribute] attributes, set[loc] locations) = class(name, attributes, [], locations); 
public Class class(str name, list[Attribute] attributes, list[Association] assocations, loc location) = class(name, attributes, assocations, {location}); 
public Class class(str name, list[Attribute] attributes, list[Association] assocations, set[loc] locations) = class(name, attributes, assocations)[@location = locations];

public Class specialisation(str name, str baseClass, loc location) = specialisation(name, baseClass, [], [], location); 
public Class specialisation(str name, str baseClass, list[Attribute] attributes, loc location) = specialisation(name, baseClass, attributes, [], location); 
public Class specialisation(str name, str baseClass, list[Attribute] attributes, set[loc] locations) = specialisation(name, baseClass, attributes, [], locations); 
public Class specialisation(str name, str baseClass, list[Attribute] attributes, list[Association] assocations, loc location) = specialisation(name, baseClass, attributes, assocations, {location}); 
public Class specialisation(str name, str baseClass, list[Attribute] attributes, list[Association] assocations, set[loc] locations) = specialisation(name, baseClass, attributes, assocations)[@location = locations];


public Class class(str name, set[str] uiscreen) = class(name)[@uiscreen = uiscreen];
public Class class(str name, str uiscreen) = class(name, {uiscreen});
public Class class(str name, list[Association] assocations, set[str] uiscreen) = class(name, [], assocations)[@uiscreen = uiscreen];
public Class class(str name, list[Association] assocations, str uiscreen) = class(name, assocations, {uiscreen});


public Class specialisation(str name, str baseClass, set[str] uiscreen) = specialisation(name, baseClass)[@uiscreen = uiscreen];
public Class specialisation(str name, str baseClass, str uiscreen) = specialisation(name, baseClass, {uiscreen});
public Class specialisation(str name, str baseClass, list[Association] assocations, set[str] uiscreen) = specialisation(name, baseClass, [], assocations)[@uiscreen = uiscreen];
public Class specialisation(str name, str baseClass, list[Association] assocations, str uiscreen) = specialisation(name, baseClass, assocations, {uiscreen});



public Attribute attr(str name, set[int] source) = attr(name)[@source = source];
public Attribute attr(str name, set[loc] locations) = attr(name)[@location = locations];
public Attribute attr(str name, loc location) = attr(name)[@location = {location}];


public Association asso(str label, str otherClass, set[int] source) = asso(label, otherClass)[@source= source];
public Association asso(str label, str otherClass, set[loc] locations) = asso(label, otherClass)[@location= locations];
public Association asso(str label, str otherClass, loc location) = asso(label, otherClass)[@location= {location}];
public Association asso(str label, str otherClass, set[str] uiscreen) = asso(label, otherClass)[@uiscreen= uiscreen];
public Association asso(str label, str otherClass, str uiscreen) = asso(label, otherClass, {uiscreen});




public Behavior actorActivity(str input, str name, str activity, str entity, set[int] source)
	= actorActivity(input, name, activity, entity)[@source=source];
public set[Behavior] actorActivityMultiple(str input, str name, str activity, set[str] entities, set[int] source)
	= {actorActivity(input, name, activity, e, source) | e <- entities};
public Behavior actorActivity(str name, str activity, str entity, set[int] source)
	= actorActivity("", name, activity, entity, source);
public set[Behavior] actorActivityMultiple(str name, str activity, set[str] entities, set[int] source)
	= {actorActivity(name, activity, e, source) | e <- entities};	
public Behavior processActivity(str input, str name, str activity, str entity, set[int] source)
	= processActivity(input, name, activity, entity)[@source=source];
public set[Behavior] processActivityMultiple(str input, str name, str activity, set[str] entities, set[int] source)
	= {processActivity(input, name, activity, e, source) | e <- entities};
public set[Behavior] processActivityMultiple(set[str] inputs, str name, str activity, set[str] entities, set[int] source)
	= {*processActivityMultiple(i, name, activity, entities, source) | i <- inputs };
public set[Behavior] processActivityMultiple(set[str] inputs, str name, str activity, entity, set[int] source)
	= {processActivity(i, name, activity, entity, source) | i <- inputs };
public Behavior processActivity(str name, str activity, str entity, set[int] source)
	= processActivity("", name, activity, entity, source);
public set[Behavior] processActivityMultiple(str name, str activity, set[str] entities, set[int] source)
	= {processActivity(name, activity, e, source) | e <- entities};	
public Behavior composedOutOf(str input, str entity, set[str] sourceEntitys, set[int] source)
	= composedOutOf(input, entity, sourceEntitys)[@source = source];
public Behavior composedOutOf(str entity, set[str] sourceEntitys, set[int] source)
	= composedOutOf("", entity, sourceEntitys, source);
	
alias BehaviorRelations = set[Behavior];

