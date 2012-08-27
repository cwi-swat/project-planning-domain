module Analysis::ModelLinks

import IO;
import Node;
import Relation;
import Set;

import Model::MetaDomain;

alias ConceptLinks = rel[set[str] concept, bool inDomainModel, bool inDictionary, bool inBehavior];

anno set[str] node@alternativeNames;

public ConceptLinks getLinkageBetween(DomainModel model, Dictionary dictionary, BehaviorRelations behavior) {
	set[str] allConcepts = {};
	visit (model) {
		case class(str name, _,_) : allConcepts += {name};
		case specialisation(str name, str super, _,_) : allConcepts += {name, super};
		case asso(_, str other,_ ,_) : allConcepts += {other};
	}
	allConcepts += {*(n@alternativeNames) | n <- model, n@alternativeNames?};
	allConcepts += {name | term(str name, _) <- dictionary};
	visit(behavior) {
		case actorActivity(str input, _, _, str output) : allConcepts += {input, output};	
		case processActivity(str input, _, _, str output) : allConcepts += {input, output};	
		case composedOutOf(str input, str output, set[str] inputs): allConcepts += {input, output, *inputs};
	}
	allConcepts -= {""}; //remove empty entity
	
	ConceptLinks result = {};
	result = {<{c}, /c := model, term(c,_) <- dictionary, /c := behavior> | c <- allConcepts};
	// now lets join the synonyms
	for (n <- model, n@alternativeNames?) {
		if (str normalName := n[0]) {
			for (str altName <- n@alternativeNames) {
				result = visit(result) {
					case set[str] s:{altName, _*} => s + {normalName}
				};
			}	
		}
	}
	// now join the results
	concepts = domain(result);
	oldResult = result;
	result = {};
	for (c <- concepts) {
		cs = oldResult[c];
		if (size(cs) != 1) {
			<newcs, cs> = takeOneFrom(cs);	
			for (ocs <- cs) {
				newcs[1] = newcs[1] || ocs[1];	
				newcs[2] = newcs[2] || ocs[2];	
				newcs[3] = newcs[3] || ocs[3];	
			}
			cs = newcs;
		}
		result += {<c, cse[0], cse[1], cse[2]> | cse <- cs};	
	}
	return result;
}