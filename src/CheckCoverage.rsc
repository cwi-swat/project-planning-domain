module CheckCoverage

import Analysis::FactCoverage;
import Domain::Project;
import Data::Facts;
import Analysis::ModelLinks;
import lang::csv::IO;

import IO;

public void main() {
	Facts unused = getUnusedFacts({2}, project, ProjectDict, ProjectBehavior);
	writeFacts(unused, |project://projectdomain/src/unused.csv|);
	links = getLinkageBetween(project, ProjectDict, ProjectBehavior, true);
	writeCSV(links, |rascal:///links.csv|, ("separator": ";"));
}