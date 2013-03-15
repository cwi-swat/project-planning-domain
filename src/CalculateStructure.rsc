module CalculateStructure

import Set;
import List;
import Relation;
import Map;
import IO;
import Node;
import String;
import util::Math;
import Model::MetaDomain;
import Model::Mapping;
import Model::Simplify;
import analysis::graphs::Graph;
import lang::csv::IO;

import MCS;
import Domain::Project;
import systems::endeavour::Model;
import systems::endeavour::Mapping;
import systems::endeavour::UIModel;
import systems::endeavour::UIMapping;
import systems::endeavour::UIInternalMapping;
import systems::openpm::Model;
import systems::openpm::Mapping;
import systems::openpm::UIModel;
import systems::openpm::UIMapping;
import systems::openpm::UIInternalMapping;

private rel[str, str] getNameMappingsRelation(ModelMappings mappings) 
	= {<m.sourceName,  m.targetName> | m <- mappings, m has targetName, m has sourceName, !(m has correct) || ( m has correct &&  m.correct)}
	+ {<m.sourceName, tm> | m <- mappings, m has targetNames, tm <- m.targetNames, m has sourceName, !(m has correct) || ( m has correct &&  m.correct)}
	+ {<ms, m.targetName> | m <- mappings, m has sourceNames, ms <- m.sourceNames, !(m has correct) || ( m has correct &&  m.correct)}
	;
/*
private map[str, str] getNameMappings(ModelMappings mappings) 
	= ( f : t | <f,t> <- getNameMappingsRelation(mappings));
*/

private set[str] mapOntoReference(str src, rel[str, str] mappings) {
	if (mappings[src] != {})
		return mappings[src];
	else
		return {src};
}
		

private set[str] mapOntoReference(set[str] src, ModelMappings mappings) {
	mappedNames = getNameMappingsRelation(mappings);
	return { *mapOntoReference(s, mappedNames) | s <- src};
}

private Graph[str] mapOntoReference(Graph[str] src, ModelMappings mappings) {
	mappedNames = getNameMappingsRelation(mappings);
	return {<tm, fm> | <t,f> <- src, tm <- mapOntoReference(t, mappedNames), fm <- mapOntoReference(f, mappedNames)};
}

private real calculateSimularityUndirected(Graph[&T] a, Graph[&T] b)
	= calculateSimularity({{t,f} | <t,f> <- a}, {{t,f} | <t,f> <- b});

private real calculateSimularity({}, {}) = 1.0;
private real calculateSimularity(set[&T] a, set[&T] b)
	= round((size(a & b) / toReal(size(a + b))) * 100)/100.0;
	

private set[set[&T]] makeUndirected(Graph[&T] src) = { {f,t} | <f,t> <- src};

private Graph[&T] inheritRelations(Graph[&T] src, Graph[&T] spec) {
	parents = spec;
	newRelations ={ *{<s, t> | p <- parents[s], t<- src[p]} | s <- domain(spec)}; 
//	println(newRelations);
	return src + newRelations;
}


private Graph[str] mapGraph(DomainModel ref, DomainModel target, ModelMappings mappings) {
	<refAssocs,_,_> = extractGraphs(ref);
	<targetAssocs,_,targetSpecs> = extractGraphs(target);
	targetAssocs = inheritRelations(targetAssocs, targetSpecs);
	targetAssocs = mapOntoReference(targetAssocs, mappings);
	return targetAssocs + targetAssocs<1,0>;
}

private void printGraphVars(str prefix, DomainModel ui, DomainModel src, ModelMappings uiMapping, ModelMappings srcMapping, ModelMappings internalMapping) {
	<assocs, _, specs> = extractGraphs(ui);
	assocs = inheritRelations(assocs, specs);
	assocs = assocs + assocs<1,0>;
	println("public Graph[str] <prefix>_UI = <assocs>;");
	println("public Graph[str] <prefix>_UI_Reference = <mapGraph(project, ui, uiMapping)>;");
	println("public Graph[str] <prefix>_SRC_Reference = <mapGraph(project, src, srcMapping)>;");
	println("public Graph[str] <prefix>_SRC_UI = <mapGraph(ui, src, internalMapping)>;");
}


private tuple[real entityRecall, real entityPrecision, real relationRecall, real relationPrecision] calculateGlobalRecallPrecision(DomainModel ref, DomainModel target, ModelMappings mappings) {
	<refAssocs,_,refSpecs> = extractGraphs(ref);
	<targetAssocs,_,targetSpecs> = extractGraphs(target);
	targetAssocs = mapOntoReference(targetAssocs, mappings);
	targetSpecs = mapOntoReference(targetSpecs, mappings);
	mappedNames = getNameMappingsRelation(mappings);
	
	refAssocs = inheritRelations(refAssocs, refSpecs);
	targetAssocs = inheritRelations(targetAssocs, targetSpecs);
	
	relRecall = (0.0+size(refAssocs & targetAssocs))/size(refAssocs);
	relPrecision = (0.0+size(refAssocs & targetAssocs))/size(targetAssocs);
	
	refEntities = getEntities(ref);
	targetEntities = getEntities(target);
	targetEntities = mapOntoReference(targetEntities, mappings);
	
	entRecall = (0.0+size(refEntities & targetEntities))/size(refEntities);
	entPrecision = (0.0+size(refEntities & targetEntities))/size(targetEntities);
	return <entRecall, entPrecision, relRecall, relPrecision>;
}

private set[str] getEntities(DomainModel dm) 
	= {m.name | m <- dm};


private tuple[real globalsimularity, lrel[str entity, str original, int overlap, int inreference, int intarget, real simularity] overlaps] analyse2(DomainModel ref, DomainModel target, ModelMappings mappings, ModelMappingFailures failures) {
	<refAssocs,_,refSpecs> = extractGraphs(ref);
	<targetAssocs,_,targetSpecs> = extractGraphs(target);
	targetAssocs = mapOntoReference(targetAssocs, mappings);
	targetSpecs = mapOntoReference(targetSpecs, mappings);
	mappedNames = getNameMappingsRelation(mappings);
	
	refAssocs = inheritRelations(refAssocs, refSpecs);
	targetAssocs = inheritRelations(targetAssocs, targetSpecs);
	
	ignoreEntities =({ *mapOntoReference(f.sourceName, mappedNames) | f <- failures} 
			+ {*mapOntoReference(m.sourceName, mappedNames) | m <- mappings, m has correct, !m.correct});
	sharedEntities = (targetAssocs<0> + targetAssocs<1> + targetSpecs<0> + targetSpecs<1>) - ignoreEntities;
	
	refEntities = refAssocs<0> + refAssocs<1> + refSpecs<0> + refSpecs<1>;
	targetEntities = targetAssocs<0> + targetAssocs<1> + targetSpecs<0> + targetSpecs<1>;
	
	// make subgraphs for the shared entities
	refAssocs = refAssocs & (sharedEntities * sharedEntities); 
	refSpecs = refSpecs & (sharedEntities * sharedEntities); 
	targetAssocs = targetAssocs & (sharedEntities * sharedEntities); 
	targetSpecs = targetSpecs & (sharedEntities * sharedEntities); 
	
	
	
	//println(refAssocs);
	//println(targetAssocs);
	
	
	refAssocsUndirected = makeUndirected(refAssocs);	
	targetAssocsUndirected = makeUndirected(targetAssocs);	
	globalSimularity = calculateSimularity(refAssocsUndirected + refSpecs, targetAssocsUndirected + targetSpecs);

	set[set[str]] getAssocs(set[set[str]] src, str ent)
		= { x | x <- src, ent in x};


	invertedMapping = invert(mappedNames);
	result = for(e <- sort([*sharedEntities])) {
		append <
			intercalate(", ", sort([*(mappedNames[invertedMapping[e]])]))
			,intercalate(", ", sort([*invertedMapping[e]]))
			, size((getAssocs(refAssocsUndirected, e) + refSpecs[e]) & (getAssocs(targetAssocsUndirected, e) + targetSpecs[e]))
			, size((getAssocs(refAssocsUndirected, e) + refSpecs[e]))
			, size((getAssocs(targetAssocsUndirected, e) + targetSpecs[e]))
			, calculateSimularity((getAssocs(refAssocsUndirected, e) + refSpecs[e]), (getAssocs(targetAssocsUndirected, e) + targetSpecs[e]))
			>;
	};
	return <globalSimularity, result>;
}

private void analyseResults(DomainModel target, ModelMappings mappings, ModelMappingFailures failures){
	<total, details> = analyse(target, mappings, failures);
	println("total simularity: <total *100>");
	for (<e, overlap, _,_, s>  <- details) {
		println(" <e>: <s*100> (<overlap>)");
	}
}


private void printRelationMapping(str name, DomainModel ref, DomainModel target, ModelMappings mappings, ModelMappingFailures failures) {
	println(name);
	<sim, ent> = analyse2(ref, target, mappings, failures);
	println("similarity: <sim>");
	
	
	ent = visit(ent) {
		case real x => 0.0
			when x == 0.0	
	};
	str printFixed(int n) = "<n>";
	str printFixed(real n) = left("<n>", 4, "0");
	str printFixed(str n) = n;
	
	if (/<f:.*> -\> <t:.*>/ := name) {
		println("\\tableEntitySim{<f>}{<t>}{}{");
	}
	
	for (r <- ent) {
		println("\t\\relationMapping<(""| it + "{<printFixed(e)>}" | e <- r)>");
	}
	println("}");
	println();
	println();
	
	str round4(real n) = printFixed(round(n * 1000) / 1000.0);
	r = calculateGlobalRecallPrecision(ref, target, mappings);
	println("\\rpDetails<("{<name>}"| it + "{<round4(e)>}" | e <- r)>");
	println();
	println();
}


private void printMappingUsage(lrel[str from, str to, ModelMappings mm, ModelMappingFailures mf] mappingCombos) {
	successful = ["equalName", "synonym", "extension", "implementationDetail", "specialisation"];
	failures = ["missing", "implementation", "domainDetail", "tooDetailed"];
	println(("Category" | "<it> & \\multicolumn{2}{c}{\\mappedOnto{<from>}{<to>}}"  | <from, to, _, _> <- mappingCombos) + " \\\\");	
	println("\\cmidrule(l){2-<1+size(mappingCombos)*2>}");
	println(("" | "<it> & <from> & <to>"  | <from, to, _, _> <- mappingCombos) + " \\\\ \\midrule");	
	list[int] totals;
	list[int] targetTotals;
	void resetTotals() {
		totals = [ 0 | n <- mappingCombos.from];
		targetTotals = totals;
	}
	void printTotals(bool doTarget = true) {
		println("\\addlinespace");
		println(("Total" | "<it> & <totals[i]> & <doTarget ? "<targetTotals[i]>": "-">" | i <- [0..size(totals)]) + "\\\\ \\midrule");
	}
	void printMappedLine(str n, list[set[node]] ts, bool doTarget = true) {
		println((n | "<it> & <getMappingCount(n, t)> & <doTarget ? "<getMappingTargetCount(n,t)>": "-">" | t <- ts) + "\\\\");
		for (i <- [0..size(totals)]) {
			totals[i] = totals[i] + getMappingCount(n, ts[i]);	
			if (doTarget) {
				targetTotals[i] = targetTotals[i] + getMappingTargetCount(n, ts[i]);	
			}
		}	
	}
	resetTotals();
	for (s <- successful) {
		printMappedLine(s, mappingCombos.mm);
	}
	printTotals();
	resetTotals();
	for (s <- failures) {
		printMappedLine(s, mappingCombos.mf, doTarget = false);
	}
	printTotals(doTarget = false);
	
}


public void main() {
/*
	printRelationMapping("Endeavour UI -\> Reference", project, endeavourUI, endeavourUIMapping, endeavourUIFailures);
	printRelationMapping("Endeavour SRC -\> Endeavour UI", endeavourUI, endeavour, endeavourUIInternalMapping, endeavourUIInternalFailures);
	printRelationMapping("Endeavour SRC -\> Reference", project, endeavour, endeavourMapping, endeavourFailures);
	
	printRelationMapping("OpenPM UI -\> Reference", project, openpmUI, openpmUIMapping, openpmUIFailures);
	printRelationMapping("OpenPM SRC -\> OpenPM UI", openpmUI, openpm, openpmUIInternalMapping, openpmUIInternalFailures);
	printRelationMapping("OpenPM SRC -\> Reference", project, openpm, openpmMapping, openpmFailures);
*/
	
	printMappingUsage([
		<"USR", "REF", endeavourUIMapping, endeavourUIFailures>
		, <"SRC","REF", endeavourMapping, endeavourFailures>
		, <"SRC", "USR", endeavourUIInternalMapping, endeavourUIInternalFailures>
	]);
	println();	
	
	printMappingUsage([
		<"USR", "REF", openpmUIMapping, openpmUIFailures>
		, <"SRC","REF", openpmMapping, openpmFailures>
		, <"SRC", "USR", openpmUIInternalMapping, openpmUIInternalFailures>
	]);
		
	/*<assocs, _, specs> = extractGraphs(project);
	assocs = inheritRelations(assocs, specs);
	assocs = assocs + assocs<1,0>;
	println("public Graph[str] reference = <assocs>;");
	printGraphVars("endeavour", endeavourUI, endeavour, endeavourUIMapping, endeavourMapping, endeavourUIInternalMapping);
	printGraphVars("openPM", openpmUI, openpm, openpmUIMapping, openpmMapping, openpmUIInternalMapping);
	*/
	printRecallPrecision(getMappedGraphs());
}

alias MappedDomain = tuple[set[str] entities, Graph[str] relations];

alias MappedGraphs = lrel[str name, MappedDomain ui, MappedDomain src, MappedDomain srcui, MappedDomain uiClean];


private Graph[&T] makeUndirected2(Graph[&T] inp) = inp + inp<1,0>;

private Graph[str] getMappedGraph(DomainModel target, ModelMappings mm)
	= makeUndirected2(mapGraph(project, target, mm));
	
private set[str] getMappedEntities(DomainModel target, ModelMappings mm) 
	= mapOntoReference(getEntities(target), mm);
	
private MappedDomain getMappedDomain(DomainModel target, ModelMappings mm)
	= <getMappedEntities(target,mm), getMappedGraph(target, mm)>;
	
private MappedDomain getCleanDomain(DomainModel target)
	= <getEntities(target), getFlatGraph(target)>;

private MappedGraphs getMappedGraphs() {
	return [
		<"Endeavour", getMappedDomain(endeavourUI, endeavourUIMapping), getMappedDomain(endeavour, endeavourMapping), getMappedDomain(endeavour, endeavourUIInternalMapping), getCleanDomain(endeavourUI)>
		, <"OpenPM", getMappedDomain(openpmUI, openpmUIMapping), getMappedDomain(openpm, openpmMapping), getMappedDomain(openpm, openpmUIInternalMapping), getCleanDomain(openpmUI)>
	];
}

private Graph[str] getFlatGraph(DomainModel dm) {
	<assocs, _, specs> = extractGraphs(dm);
	return makeUndirected2(inheritRelations(assocs, specs));
}

private real getRecall(Graph[&T] expected, Graph[&T] found)
	= getRecall(makeUndirected(expected), makeUndirected(found));
private real getRecall(set[&T] expected, set[&T] found)
	= (0.0+ size(expected & found)) / size(expected);

private real getPrecision(Graph[&T] expected, Graph[&T] found)
	= getPrecision(makeUndirected(expected), makeUndirected(found));
	
private real getPrecision(set[&T] expected, set[&T] found)
	= (0.0+ size(expected & found)) / size(found);
	
private real getSimilarity(Graph[str] expected, Graph[str] found) 
	= (1.0 - distance(expected, found));
	
private void printRecallPrecision(MappedGraphs mg) {
	referenceGraph = getFlatGraph(project);
	referenceEntities = getEntities(project);
	for (<str nm, MappedDomain ui, MappedDomain src, MappedDomain srcui, MappedDomain uiclean> <- mg) {
		observedEntities = referenceEntities & ui.entities;
		recoveredEntities = referenceEntities & src.entities;
		observedRelations = ui.relations & (observedEntities * observedEntities);
		recoveredRelations = src.relations & (recoveredEntities * recoveredEntities);
		
		rowResult = [
			<"\\OBS" ,"\\mappedOnto{\\USR}{\\REF}" 
				, 2.0
				, 2.0
				, getPrecision(referenceEntities, ui.entities)
				, getPrecision(referenceGraph, ui.relations)
				, getSimilarity(referenceGraph, ui.relations)
			>
			, <"\\REC", "\\mappedOnto{\\SRC}{\\REF}"
				, 2.0
				, 2.0
				, getPrecision(referenceEntities, src.entities)
				, getPrecision(referenceGraph, src.relations)
				, getSimilarity(referenceGraph, src.relations)
			>
			, <"\\INT", "\\mappedOnto{\\SRC}{\\USR}"
				, getRecall(uiclean.entities, srcui.entities)
				, getRecall(uiclean.relations, srcui.relations)
				, getPrecision(uiclean.entities, srcui.entities)
				, getPrecision(uiclean.relations, srcui.relations)
				, getSimilarity(uiclean.relations, srcui.relations)
			>
			, <"\\LIM", "\\mappedOnto{\\REC}{\\ensuremath{\\text{\\OBS}\\cup\\text{\\REC}}}"
				, getRecall(observedEntities + recoveredEntities, recoveredEntities)
				, getRecall(observedRelations + recoveredRelations, recoveredRelations)
				, 2.0
				, 2.0
				, getSimilarity(observedRelations + recoveredRelations, recoveredRelations)
			>
		];
		str printFixed(real n) = left("<n>", 4, "0");
		str roundCustom(real n) = n == 2.0 ? "-" : printFixed(round(n * 100) / 100.0);
		str roundCustom(str n) = n;
		println("\\recallPrecisionResult{<nm>}{");
		for (r <- rowResult) {
			rlist = [c | c <-r ];
			println(("\t<r[0]>" | "<it> & <roundCustom(c)>" | c <- rlist[1..]) + "\\\\");
		} 	
		println("}");
		println("");
		
	}
}






public void checkEverythingIsMapped() {
	bool isMapped(DomainModel dm,  ModelMappings mm, ModelMappingFailures mmf) {
		ents = { c.name | Class c <- dm};
		maps =  (getMappedNames(mm) + getMappedNames(mmf));
		println((ents-maps) + (maps-ents));
		return ents == maps;
	}	
	println("endeavour SRC: <isMapped(endeavour, endeavourMapping, endeavourFailures)>");
	println("endeavour UI: <isMapped(endeavourUI, endeavourUIMapping, endeavourUIFailures)>");
	println("endeavour internal: <isMapped(endeavour, endeavourUIInternalMapping, endeavourUIInternalFailures)>");
	println("openpm SRC: <isMapped(openpm, openpmMapping, openpmFailures)>");
	println("openpm UI: <isMapped(openpmUI, openpmUIMapping, openpmUIFailures)>");
	println("openpm internal: <isMapped(openpm, openpmUIInternalMapping, openpmUIInternalFailures)>");
}

private set[str] getMappedNames(set[node] target)
	= {src | n <- target, n has sourceName, str src := getChildren(n)[0]}
		+ {*src | n <- target, n has sourceNames,  set[str] src := getChildren(n)[0] }
	;

private int getEntityCount(set[node] target) 
	= size(
		{src | n <- target, n has sourceName, str src := getChildren(n)[0]}
		+ {*src | n <- target, n has sourceNames,  set[str] src := getChildren(n)[0] }
	);

private int getMappingCount(str nm, set[node] target) 
	= size(
		{src | n <- target, getName(n) == nm,  n has sourceName, str src := getChildren(n)[0], n has correct ==> (getChildren(n)[-1] == true) }
		+ {*src | n <- target, getName(n) == nm, n has sourceNames, set[str] src := getChildren(n)[0], n has correct ==> (getChildren(n)[-1] == true) }
	);

private int getMappingTargetCount(str nm, set[node] target) 
	= size(
		{tar | n <- target, getName(n) == nm,  n has targetName, str tar := getChildren(n)[1], n has correct ==> (getChildren(n)[-1] == true) }
		+ {*tar | n <- target, getName(n) == nm,  n has targetNames, set[str] tar := getChildren(n)[1], n has correct ==> (getChildren(n)[-1] == true) }
	);

private tuple[str,int,int,str] getMappingCounts(str nm, str expl)
	= <nm, getMappingCount(nm, endeavourMapping), getMappingCount(nm, openpmMapping), expl>;
	
private tuple[str,int,int,str] getFailedMappingCounts(str nm, str expl)
	= <nm, getMappingCount(nm, endeavourFailures), getMappingCount(nm, openpmFailures), expl>;