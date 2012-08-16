module Model::MetaDomain


data Class 
	= class(str name, list[Attribute] attributes, list[Association] assocations)
	| specialisation(str name, str baseClass, list[Attribute] attributes, list[Association] assocations)
	;
	
public anno set[str] Class@alternativeNames;

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



data Attribute = attr(str name);

public Attribute attr(str name, set[int] source) = attr(name)[@source = source];

data Association = asso(str label, str otherClass, Cardinality from, Cardinality to);

public Association asso(str label, str otherClass) = asso(label, otherClass, none(), none());
public Association asso(str label, str otherClass, set[int] source) = asso(label, otherClass)[@source= source];
public Association asso(str label, str otherClass, Cardinality from, Cardinality to, set[int] source) = asso(label, otherClass, from, to)[@source= source];

anno str Association@class;

data Cardinality = none() | \one() | oneOrMore() | noneOrMore();


anno set[int] Class@source;
anno set[int] Attribute@source;
anno set[int] Association@source;
anno set[int] Cardinality@source;


alias DomainModel = set[Class];

data DictionaryWord = term(str name, set[int] descriptions);
alias Dictionary = set[DictionaryWord];

data Behavior 
	= actorActivity(str input, str name, str activity, str entity)
	| processActivity(str input, str name, str activity, str entity)
	| composedOutOf(str input, str entity, set[str] sourceEntities)
	;
anno set[int] Behavior@source;

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

