module systems::endeavour::analyze

import IO;
import ValueIO;
import Relation;
import util::FastPrint;
import util::Resources;
import lang::java::jdt::JDT;
import lang::java::jdt::Java;

private Resource getProjectData() {
	cache = |rascal:///endeavour.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#Resource, cache);
	}
	proj = extractProject(|project://Endeavour-Mgmt/|);	
	writeBinaryValueFile(cache, proj);
	return proj;
}

public void main() {
	proj = getProjectData();
	domainMethods = { m | <l, m> <- proj@declaredMethods, entity([_*,package("model"),_*]) := m};
	incomingCalls =	{<t, c> | <c, t> <- proj@calls, t in domainMethods, entity([_*, package("model"),_*]) !:= c};
	for (m <- domain(incomingCalls)) {
		println("<readable(m)> called by:");
		for (c <- incomingCalls[m]) 
			println("\t" + readable(c));
	}
}
