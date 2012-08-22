module CheckCoverage

import Analysis::FactCoverage;
import Domain::Project;
import Data::Facts;

import IO;

public void main() {
	Facts unused = getUnusedFacts({2}, project, ProjectDict, ProjectBehavior);
	println(unused);
	writeFacts(unused, |project://projectdomain/src/unused.csv|);
}