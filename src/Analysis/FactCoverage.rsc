module Analysis::FactCoverage

import IO;
import Node;
import Relation;
import Data::Facts;
import Domain::Project;

set[int] validSources = {2};

anno set[int] node@source;

public Facts getProjectUnusedFacts() {
	facts = readFacts();
	usedFacts = { *(x@source) | /node x := project, (x@source)?};	
	return {x | x:<f,s,_,_> <- facts, s in validSources, !(f in usedFacts)}; 
}

public void writeUnusedFacts() {
	writeFacts(getProjectUnusedFacts(), |project://projectdomain/src/unused.csv|);
}