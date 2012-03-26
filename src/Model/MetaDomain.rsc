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