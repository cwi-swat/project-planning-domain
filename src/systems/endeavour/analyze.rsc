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
import lang::java::jdt::JavaADT;
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

private set[Entity] getModelClasses(Resource proj) {
	return { c | <_,c> <- proj@types, entity([*modelOnly,_*]) := c};	
}

private set[AstNode] getModelAst(Resource proj) {
	cache = |rascal:///endeavour-adt.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#set[AstNode], cache);
	}
	result = {createAstFromFile(l) | <l, t> <- proj@types, entity([*modelOnly,_*]) := t};;	
	writeBinaryValueFile(cache, result);
	return result;
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
private bool biprintln(value v) {
	iprintln(v);
	return true;
}

public void visualizeDomainLinks3() {
	proj = getProjectData();
	domainClasses = getModelClasses(proj);
	domainASTs = getModelAst(proj);
	domainLinks = {<t@javaType, ft@javaType> | /t:typeDeclaration(_,_,_,_,_,_,_, b) <- domainASTs,
		t@javaType in domainClasses,
		f:fieldDeclaration(_,_,ft,_) <- b,  
		ft@javaType in domainClasses};
	// now add the relations in generic classes
	domainLinks += {<t@javaType, fe@javaType> | /t:typeDeclaration(_,_,_,_,_,_,_, b) <- domainASTs,
		t@javaType in domainClasses,
		f:fieldDeclaration(_,_,ft,_) <- b,  
		ft.genericTypes?,
		fe <- ft.genericTypes,
		fe@javaType in domainClasses};
	nodes = [box(text(printable(c)), id(readable(c)), resizable(false)) | c <- domainClasses];
	edges = [edge(readable(f), readable(t)) | <f, t> <- domainLinks];
	
	render(graph(nodes, edges, size(1000), vgap(10), hgap(5), hint("layered")));
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
