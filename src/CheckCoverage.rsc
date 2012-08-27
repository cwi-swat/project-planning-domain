module CheckCoverage

import Analysis::FactCoverage;
import Domain::Project;
import Data::Facts;
import Analysis::ModelLinks;

import IO;

public void main() {
	Facts unused = getUnusedFacts({2}, project, ProjectDict, ProjectBehavior);
	writeFacts(unused, |project://projectdomain/src/unused.csv|);
	
	
	iprintln(getLinkageBetween(project, ProjectDict, ProjectBehavior));
}