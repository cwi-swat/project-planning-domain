module systems::endeavour::analyze

import IO;
import ValueIO;
import Relation;
import Set;
import Map;
import String;
import util::FastPrint;
import util::Resources;
import lang::java::jdt::JDT;
import lang::java::jdt::Java;
import vis::Figure;
import vis::Render;

public Resource getProjectData() {
	cache = |rascal:///endeavour.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#Resource, cache);
	}
	proj = extractProject(|project://Endeavour-Mgmt/|);	
	writeBinaryValueFile(cache, proj);
	return proj;
}

public void main() {
	visualizeDomainLinks2();
}

private list[Id] modelOnly = [package("org"),package("endeavour"),package("mgmt"),package("model")];

private str printable(Entity e) {
	return readable(entity(e.id - modelOnly));
}

public void visualizeDomainLinks() {
	proj = getProjectData();
	domainClasses = { c | <_,c> <- proj@types, entity([*modelOnly,_*]) := c};
	domainLinks = {<entity(cf), entity(ct)> | <f,t> <- proj@calls
		, entity([*cf, method(_,_,_)]) := f, [*modelOnly,_*] := cf
		, entity([*ct, method(_,_,_)]) := t, [*modelOnly,_*] := ct
		, ct != cf
		};
	nodes = [box(text(printable(c)), id(readable(c)), resizable(false)) | c <- domainClasses];
	edges = [edge(readable(f), readable(t)) | <f, t> <- domainLinks];
	render(graph(nodes, edges, size(600), vgap(10), hgap(5), hint("layered")));
}

public void visualizeDomainLinks2() {
	proj = getProjectData();
	domainClasses = { c | <_,c> <- proj@types, entity([*modelOnly,_*]) := c};
	map[tuple[Entity, Entity], int] domainLinks = ();
	for( <f,t> <- proj@calls
		, entity([*cf, method(fname,_,_)]) := f, [*modelOnly,_*] := cf
		, entity([*ct, method(tname,_,_)]) := t, [*modelOnly,_*] := ct
		, ct != cf) {
		domainLinks[<entity(cf), entity(ct)>] ? 0 += 1;		
	}
	cScale = 200 / max(range(domainLinks));
	nodes = [box(text(printable(c)), id(readable(c)), resizable(false)) | c <- domainClasses];
	edges = [edge(readable(f), readable(t), lineColor(gray(55 + cScale * domainLinks[<f,t>]))) | <f, t> <- domainLinks];
	render(graph(nodes, edges, size(600), vgap(10), hgap(5), hint("layered")));
}

public void printDomainMethodsUsed() {
	proj = getProjectData();
	domainMethods = { m | <l, m> <- proj@declaredMethods, entity([*modelOnly,_*]) := m};
	incomingCalls =	{<t, c> | <c, t> <- proj@calls, t in domainMethods, entity([*modelOnly,_*]) !:= c};
	for (m <- domain(incomingCalls)) {
		println("<readable(m)> called by:");
		for (c <- incomingCalls[m]) 
			println("\t" + readable(c));
	}
}
