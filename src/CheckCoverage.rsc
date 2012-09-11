module CheckCoverage

import Analysis::FactCoverage;
import Domain::Project;
import Data::Facts;
import Analysis::ModelLinks;
import lang::csv::IO;

import IO;
import Set;
import List;

public void main() {
	Facts unused = getUnusedFacts({2}, project, ProjectDict, ProjectBehavior);
	writeFacts(unused, |project://projectdomain/src/unused.csv|);
	links = getLinkageBetween(project, ProjectDict, ProjectBehavior, true);
	rel[str concept, bool inDomainModel, bool inDictionary, bool inBehavior] newLinks = {<("" | it == "" ? s : it + ", " + s | s<- sort(toList(l[0]))), l[1], l[2], l[3]> | l <- links};
	loc target = |rascal:///links.csv|;
	writeCSV(newLinks, target, ("separator": ";"));
	sortCSV(target);
}

private void sortCSV(loc f) {
	<header, lines> = headTail(readFileLines(f));
	writeFile(f, (header | it +"\n" + l | l <- sort(lines)));
}