module Analysis::FactCoverage

import IO;
import Node;
import Relation;
import Data::Facts;
import Domain::Project;
import Model::MetaDomain;


anno set[int] node@source;

public Facts getUnusedFacts(set[int] validSources, DomainModel model, Dictionary dictionary, BehaviorRelations behavior) {
	facts = readFacts();
	usedFacts = { *(x@source) | /node x := model, (x@source)?};	
	usedFacts += { *(w.descriptions) | DictionaryWord w <- dictionary};	
	usedFacts += { *(x@source) | /node x := behavior, (x@source)?};	
	return {x | x:<f,s,_,_> <- facts, s in validSources, !(f in usedFacts)}; 
}
