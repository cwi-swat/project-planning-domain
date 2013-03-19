module Compare::CalculateStructure

import Set;
import List;
import Relation;
import Map;
import IO;
import Node;
import String;
import util::Math;
import Meta::Domain;
import Meta::Mapping;
import Meta::Simplify;
import analysis::graphs::Graph;
import lang::csv::IO;

import Compare::MCS;
import Reference::Model;
import systems::endeavour::SRCModel;
import systems::endeavour::SRCMapping;
import systems::endeavour::USRModel;
import systems::endeavour::USRMapping;
import systems::endeavour::INTMapping;
import systems::openpm::SRCModel;
import systems::openpm::SRCMapping;
import systems::openpm::USRModel;
import systems::openpm::USRMapping;
import systems::openpm::INTMapping;

private rel[str, str] getNameMappingsRelation(ModelMappings mappings) 
	= {<m.sourceName,  m.targetName> | m <- mappings, m has targetName, m has sourceName, !(m has correct) || ( m has correct &&  m.correct)}
	+ {<m.sourceName, tm> | m <- mappings, m has targetNames, tm <- m.targetNames, m has sourceName, !(m has correct) || ( m has correct &&  m.correct)}
	+ {<ms, m.targetName> | m <- mappings, m has sourceNames, ms <- m.sourceNames, !(m has correct) || ( m has correct &&  m.correct)}
	;

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

private set[str] getEntities(DomainModel dm) 
	= {m.name | m <- dm};


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
	printMappingUsage([
		<"USR", "REF", endeavourUSRMapping, endeavourUSRMappingFailures>
		, <"SRC","REF", endeavourSRCMapping, endeavourSRCMappingFailures>
		, <"SRC", "USR", endeavourINTMapping, endeavourINTMappingFailures>
	]);
	println();	
	
	printMappingUsage([
		<"USR", "REF", openpmUSRMapping, openpmUSRMappingFailures>
		, <"SRC","REF", openpmSRCMapping, openpmSRCMappingFailures>
		, <"SRC", "USR", openpmINTMapping, openpmINTMappingFailures>
	]);
	
	printRecallPrecision(getMappedGraphs());
}

alias MappedDomain = tuple[set[str] entities, Graph[str] relations];

alias MappedGraphs = lrel[str name, MappedDomain ui, MappedDomain src, MappedDomain srcui, MappedDomain uiClean];


private Graph[&T] makeUndirected2(Graph[&T] inp) = inp + inp<1,0>;

private Graph[str] getMappedGraph(DomainModel target, ModelMappings mm)
	= makeUndirected2(mapGraph(Reference, target, mm));
	
private set[str] getMappedEntities(DomainModel target, ModelMappings mm) 
	= mapOntoReference(getEntities(target), mm);
	
private MappedDomain getMappedDomain(DomainModel target, ModelMappings mm)
	= <getMappedEntities(target,mm), getMappedGraph(target, mm)>;
	
private MappedDomain getCleanDomain(DomainModel target)
	= <getEntities(target), getFlatGraph(target)>;

private MappedGraphs getMappedGraphs() {
	return [
		<"Endeavour", getMappedDomain(endeavourUSR, endeavourUSRMapping), getMappedDomain(endeavourSRC, endeavourSRCMapping), getMappedDomain(endeavourSRC, endeavourINTMapping), getCleanDomain(endeavourUSR)>
		, <"OpenPM", getMappedDomain(openpmUSR, openpmUSRMapping), getMappedDomain(openpmSRC, openpmSRCMapping), getMappedDomain(openpmSRC, openpmINTMapping), getCleanDomain(openpmUSR)>
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
	referenceGraph = getFlatGraph(Reference);
	referenceEntities = getEntities(Reference);
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