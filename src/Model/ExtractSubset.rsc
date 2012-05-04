module Model::ExtractSubset

import Model::MetaDomain;
import Model::Simplify;
import Set;

public set[str] getAllClassNames(DomainModel model)
	= { c.name | c <- model};
	
public DomainModel getSubset(DomainModel model, set[str] subsetClasses) {
	result = { c | c <- model, c.name in subsetClasses};
	assocClasses = {aso@class | /aso:asso(_,t,_,_) := result, t in subsetClasses, aso@class?};
	result += {c | c <- model, c.name in assocClasses};
	
	Class cleanup(Class c) {
		newAsso = [];
		newAttr = c.attributes;
		for (a <- c.assocations) {
			if (asso(l,t,_,_) := a, !(t  in subsetClasses)) {
				newAttr += attr("<l> : <t>", a@source? ? a@source: {});
			}
			else {
				newAsso += [a];
			}
		}	
		return c[assocations = newAsso][attributes = newAttr];
	};
	return { cleanup(c) | c <- result};
}


public set[str] getRelatedTo(DomainModel model, str root, int levels) {
	set[str] result = {root};
	<assocs, assocClasses, specs> = extractGraphs(model);
	extends = specs<1,0>;
	for (i <- [0..(levels - 1)]) {
		as = assocs[result];
		asClasses = assocClasses[as * result];
		result += as + asClasses;
		result += specs[result];
		result += extends[result];
	}
	return result;
}