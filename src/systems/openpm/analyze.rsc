module systems::openpm::analyze

import IO;
import ValueIO;
import Relation;
import Set;
import Map;
import String;
import List;
import util::FastPrint;
import util::Resources;
import lang::java::jdt::JDT;
import lang::java::jdt::Java;
import lang::java::jdt::JavaADT;
import vis::Figure;
import vis::Render;
import util::IDE;
import util::Clipboard;

public Resource getProjectData() {
	cache = |rascal:///openpm.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#Resource, cache);
	}
	proj = extractProject(|project://OpenPM/|, gatherASTs = false, fillASTBindings = false, fillOldStyleUsage = false);	
	writeBinaryValueFile(cache, proj);
	return proj;
}

public void main() {
	visualizeDomainLinks2();
}

private list[Id] modelOnly = [package("org"),package("tracka")];

private str printable(Entity e) {
	return readable(entity(e.id - modelOnly));
}

private bool isModelEntity(Entity c) = entity([*modelOnly,cl,_*]) := c 
	&& (class(_) := cl || class(_,_) := cl || interface(_) := cl || interface(_,_) := cl || enum(_) := cl)
	&& (cl has name ==> !endsWith(cl.name, "Test") );

private set[Entity] getModelTypes(Resource proj) {
	return { c | <_,c> <- proj@classes + proj@interfaces + proj@enums, isModelEntity(c)};	
}
private set[Entity] getModelClasses(Resource proj) {
	return { c | <_,c> <- proj@classes, isModelEntity(c)};	
}

private set[AstNode] getModelAst(Resource proj) {
	cache = |rascal:///openpm-adt.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#set[AstNode], cache);
	}
	result = {createAstFromFile(l) | <l, t> <- proj@classes + proj@interfaces + proj@enums, isModelEntity(t)};	
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
	domainTypes = getModelTypes(proj);
	map[tuple[Entity, Entity], int] domainLinks = ();
	for( <f,t> <- proj@calls
		, entity([*cf, method(fname,_,_)]) := f, isModelEntity(f)
		, entity([*ct, method(tname,_,_)]) := t, isModelEntity(t)
		, ct != cf) {
		domainLinks[<entity(cf), entity(ct)>] ? 0 += 1;		
	}
	cScale = 200 / max(range(domainLinks));
	nodes = [box(text(printable(c)), id(readable(c)), resizable(false)) | c <- domainTypes];
	edges = [edge(readable(f), readable(t), lineColor(gray(55 + cScale * domainLinks[<f,t>]))) | <f, t> <- domainLinks];
	render(graph(nodes, edges, size(600), vgap(10), hgap(5), hint("layered")));
}
private bool biprintln(value v) {
	iprintln(v);
	return true;
}

private Entity getJavaType(AstNode e) = e@bindings["typeBinding"]; 

public void visualizeDomainLinks3() {
	proj = getProjectData();
	domainTypes = getModelTypes(proj);
	domainASTs = getModelAst(proj);
	rel[Entity, Entity] domainLinks = {};
	for (/t:typeDeclaration(_,_,_,_,_,_,_, b) <- domainASTs, 
			getJavaType(t)  in domainTypes,
			f:fieldDeclaration(_,_,ft,_) <- b) {
		if (ft.genericTypes?) {
			domainLinks += {<getJavaType(t), getJavaType(fe)> | fe <- ft.genericTypes, getJavaType(fe) in domainTypes};
		}
		else if (getJavaType(ft) in domainTypes) {
			domainLinks += {<getJavaType(t), getJavaType(ft)>};	
		}		
	}
	nodes = [box(text(printable(c)), id(readable(c)), resizable(false)) | c <- domainTypes];
	edges = [edge(readable(f), readable(t)) | <f, t> <- domainLinks];
	
	render(graph(nodes, edges, size(1000), vgap(10), hgap(5), hint("layered")));
}
str quoted(str inp) = "\"" + inp + "\"";

str removeNewLines(str input) = visit(input) { case /[\n\r]\s*[\n\r]/ => "\n" };

public void writeFirstModel(loc targetFile) {
	proj = getProjectData();
	domainClasses = getModelTypes(proj);
	domainASTs = getModelAst(proj);
	rel[Entity, AstNode] entToAst = {<e, t> | e <- domainClasses, /t:typeDeclaration(_,_,_,_,_,_,_,_) <- domainASTs, getJavaType(t) == e};
	entToAst += {<e, t> | e <- domainClasses, /t:enumDeclaration(_,_,_,_,_,_) <- domainASTs, getJavaType(t) == e};
	first = true;
	str sep() { if(first) { first = false; return ""; } else { return ", "; } }
	str reset() { first= true; return ""; }
	classes = for(d <- domainClasses, entToAst[d] != {}) {
			str cl = "class(<quoted(printable(d))>,\n";
			attrs = for(t <- entToAst[d], f:fieldDeclaration(_,_,ft, n) <- t.bodyDeclarations, getJavaType(ft) notin domainClasses, nf <- n, nf.name?, toUpperCase(nf.name) != nf.name) {
				append "attr(<quoted(nf.name)>, <f@location>)";
			};
			attrs = sort(attrs);
			cl += "\t[\n\t\t" + intercalate("\n\t\t, ", attrs) + "\n\t],\n";
			list[str] assos = [];
			for(t <- entToAst[d], f:fieldDeclaration(_,_,ft, n) <- t.bodyDeclarations, nf <- n, nf.name?, toUpperCase(nf.name) != nf.name) {
				if (ft.genericTypes?) {
					for (fe <- ft.genericTypes, getJavaType(fe) in domainClasses) {
						assos += ["asso(<quoted(nf.name)>, <quoted(printable(getJavaType(fe)))>, <f@location>)"];
					}
				}
				if (getJavaType(ft) in domainClasses) {
					 assos += ["asso(<quoted(nf.name)>, <quoted(printable(getJavaType(ft)))>, <f@location>)"];
				}
			}
			assos = sort(assos);
			cl += "\t[\n\t\t" + intercalate("\n\t\t, ", assos) + "\n\t],\n";
			cl += "\t<getOneFrom(entToAst[d])@location>\n\t)";
			append cl;
	};
	classes = sort(classes);	
	writeFile(targetFile, "module X
		'import Model::MetaDomain;
		'DomainModel endeavour = {
		'	<intercalate("\n, ", classes)>
		'};");
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


public void prepareJavaEditor() {
	registerNonRascalContributions("org.eclipse.jdt.ui.CompilationUnitEditor", {
		popup(action("Copy location", void (str selected, loc filePos) {
			println(filePos);
			copy(filePos);
		}))
	});
}


public list[Id] viewOnly = [package("org"),package("endeavour"),package("mgmt"),package("view")];

public set[AstNode] getViewAst(Resource proj) {
	cache = |rascal:///endeavour-adt-views.cache|;
	if (exists(cache)) {
		return readBinaryValueFile(#set[AstNode], cache);
	}
	result = {createAstFromFile(l) | <l, t> <- proj@classes, entity([*viewOnly,_*]) := t};;	
	writeBinaryValueFile(cache, result);
	return result;
}

public void listInterestingViewMethods() {
	proj = getProjectData();
	viewAsts = getViewAst(proj);
	interestingMethods = { m | /m:methodDeclaration(_, _, _, _, _, _, _, Option[AstNode] i) <- viewAsts, some(AstNode b) := i, calcCC(b) > 3, m.name != "actionPerformed", m.name != "getValueAt" };
	for (m <- interestingMethods) {
		println("<m.name> <m@location>");
	}
}

private int calcCC(AstNode body) {
	// not accurate, but general idea of CC is used
	result = 1;
	visit (body) {
		case conditionalExpression(_,_,_) : result += 1;
		case ifStatement(_,_,_) : result += 1;
		case whileStatement(_,_) : result += 1;
		case forStatement(_,_,_,_) : result += 1;
		case switchCase(false, _) : result += 1;
		case catchClause(_, _) : result += 1;
	};
	return result;	
}