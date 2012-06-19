module Analysis::FactCoverage

import IO;
import Node;
import Relation;
import Data::Facts;
import Domain::Project;

set[int] validSources = {2};

public Facts getProjectUnusedFacts() {
	facts = readFacts();
	usedFacts = { *s | /node x := project, a := getAnnotations(x), a["source"]?, set[int] s := a["source"]};	
	return {x | x:<f,s,_,_> <- facts, s in validSources, !(f in usedFacts)}; 
	
}