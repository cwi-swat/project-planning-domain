module Model::ExtractSubset

import Model::MetaDomain;
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
