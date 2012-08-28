module Analysis::ModelLinks

import IO;
import Node;
import Relation;
import Set;
import String;

import Model::MetaDomain;

alias ConceptLinks = rel[set[str] concept, bool inDomainModel, bool inDictionary, bool inBehavior];

anno set[str] node@alternativeNames;

public ConceptLinks getLinkageBetween(DomainModel model, Dictionary dictionary, BehaviorRelations behavior)
	= getLinkageBetween(model, dictionary, behavior, false);
public ConceptLinks getLinkageBetween(DomainModel model, Dictionary dictionary, BehaviorRelations behavior, bool caseInsensitive) {
	if (caseInsensitive) {
		// now lets lower case everything to remove even more
		model = visit(model) {
			case str s => toLowerCase(s)
		}
		dictionary = visit(dictionary) {
			case str s => toLowerCase(s)
		}
		behavior = visit(behavior) {
			case str s => toLowerCase(s)
		}
	}
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
					case set[str] s:{normalName, _*} => s + {altName}
				};
			}	
		}
	}
	// now or the synonyms
	return { <c> + (getOneFrom(result[c]) | <it[0] || o[0], it[1] || o[1], it[2] || o[2] > | o <- result[c]) | c <- domain(result)};
}