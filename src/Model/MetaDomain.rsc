module Model::MetaDomain


data Class = class(str name, list[Attribute] attributes, list[Association] assocations);

data Attribute = attr(str name);
data Association = comp(str otherClass, Cardinality from, Cardinality to, str label);

anno Class Association@class;

data Cardinality = \one() | oneOrMore() | noneOrMore();

anno set[int] Class@source;
anno set[int] Attribute@source;
anno set[int] Association@source;
anno set[int] Cardinality@source;


alias DomainModel = set[Class];