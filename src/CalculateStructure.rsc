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

private map[str, str] getNameMappings(ModelMappings mappings) 
	= (m.sourceName : m.targetName | m <- mappings, m has targetName, m has sourceName)
	+ (m.sourceName : tm | m <- mappings, m has targetNames, tm <- m.targetNames, m has sourceName)
	+ (ms : m.targetName | m <- mappings, m has sourceNames, ms <- m.sourceNames)
	;

private Graph[str] mapOntoReference(Graph[str] src, ModelMappings mappings) {
	mappedNames = getNameMappings(mappings);
	return visit(src) {
		case <str s, str s2> => <mappedNames[s]?s, mappedNames[s2]?s2>
	};
}

private real calculateSimularityUndirected(Graph[&T] a, Graph[&T] b)
	= calculateSimularity({{t,f} | <t,f> <- a}, {{t,f} | <t,f> <- b});

private real calculateSimularity({}, {}) = 1.0;
private real calculateSimularity(set[&T] a, set[&T] b)
	= round((size(a & b) / toReal(size(a + b))) * 100)/100.0;
	
private tuple[real globalsimularity, lrel[str entity, int overlap, int inreference, int intarget, real simularity] overlaps] analyse(DomainModel target, ModelMappings mappings, ModelMappingFailures failures) {
	<g_ref,_,_> = extractGraphs(project);
	<g_target,_,_> = extractGraphs(target);
	g_target = mapOntoReference(g_target, mappings);
	mappedNames = getNameMappings(mappings);
	e_target = (g_target<0> + g_target<1>) - ({mappedNames[f.sourceName]?f.sourceName | f <- failures} + {mappedNames[m.sourceName]?m.sourceName | m <- mappings, m has correct, !m.correct});
	println(e_target);
	e_target += mappedNames<1>;
	println(e_target);
	g_ref = {<f,t> | <f,t> <- g_ref, f in e_target, t in e_target};
	g_target = {<f,t> | <f,t> <- g_target, f in e_target, t in e_target};
	g_ref += g_ref<1,0>; // make the relations undirected
	g_target += g_target<1,0>; // make the relations undirected
	return <calculateSimularityUndirected(g_ref, g_target),
		[<e, size(g_ref[e] & g_target[e]), size(g_ref[e]), size(g_target[e]), calculateSimularity(g_ref[e], g_target[e])>
			| e <- sort([*e_target])]
		>;
}

private set[set[&T]] makeUndirected(Graph[&T] src) = { {f,t} | <f,t> <- src};

private Graph[&T] inheritRelations(Graph[&T] src, Graph[&T] spec) {
	parents = spec;
	newRelations ={ *{<s, t> | p <- parents[s], t<- src[p]} | s <- domain(spec)}; 
//	println(newRelations);
	return src + newRelations;
}


private tuple[real globalsimularity, lrel[str entity, str original, int overlap, int inreference, int intarget, real simularity] overlaps] analyse2(DomainModel ref, DomainModel target, ModelMappings mappings, ModelMappingFailures failures) {
	<refAssocs,_,refSpecs> = extractGraphs(ref);
	<targetAssocs,_,targetSpecs> = extractGraphs(target);
	targetAssocs = mapOntoReference(targetAssocs, mappings);
	targetSpecs = mapOntoReference(targetSpecs, mappings);
	mappedNames = getNameMappings(mappings);
	
	refAssocs = inheritRelations(refAssocs, refSpecs);
	targetAssocs = inheritRelations(targetAssocs, targetSpecs);
	
	ignoreEntities =({mappedNames[f.sourceName]?f.sourceName | f <- failures} 
			+ {mappedNames[m.sourceName]?m.sourceName | m <- mappings, m has correct, !m.correct});
	sharedEntities = (targetAssocs<0> + targetAssocs<1> + targetSpecs<0> + targetSpecs<1>) - ignoreEntities;
	
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
		append <e, intercalate(", ", sort([*invertedMapping[e]]))
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
	<sim, ent> = analyse2(ref, target, mappings, failures);
	println("<name>: <sim>");
	
	ent = visit(ent) {
		case real x => 0.0
			when x == 0.0	
	};
	
	str printFixed(int n) = "<n>";
	str printFixed(real n) = left("<n>", 4, "0");
	str printFixed(str n) = n;
	
	for (r <- ent) {
		println("\\relationMapping<(""| it + "{<printFixed(e)>}" | e <- r)>");
	}
	println();
	println();
}

private void printMappingUsage(lrel[str name, ModelMappings mm, ModelMappingFailures mf] mappingCombos) {
	successful = ["equalName", "synonym", "extension", "specialisation", "implementationDetail"];
	failures = ["missing", "implementation", "domainDetail", "tooDetailed", "differentDesign"];
	println(("Category" | it + " & " + name | name <- mappingCombos.name) + " \\\\");	
	list[int] totals;
	void resetTotals() {
		totals = [ 0 | n <- mappingCombos.name];
	}
	void printTotals() {
		println("\\addlinespace");
		println(("Total" | "<it> & <t>" | t <- totals) + "\\\\ \\midrule");
	}
	void printMappedLine(str n, list[set[node]] ts) {
		println((n | "<it> & <getMappingCount(n, t)>" | t <- ts) + "\\\\");
		for (i <- [0..size(totals)]) {
			totals[i] = totals[i] + getMappingCount(n, ts[i]);	
		}	
	}
	resetTotals();
	for (s <- successful) {
		printMappedLine(s, mappingCombos.mm);
	}
	printTotals();
	resetTotals();
	for (s <- failures) {
		printMappedLine(s, mappingCombos.mf);
	}
	printTotals();
}


public void main() {
	printRelationMapping("Endeavour UI -\> Reference", project, endeavourUI, endeavourUIMapping, endeavourUIFailures);
	printRelationMapping("Endeavour SRC -\> Endeavour UI", endeavourUI, endeavour, endeavourUIInternalMapping, endeavourUIInternalFailures);
	printRelationMapping("Endeavour SRC -\> Reference", project, endeavour, endeavourMapping, endeavourFailures);
	
	printRelationMapping("OpenPM UI -\> Reference", project, openpmUI, openpmUIMapping, openpmUIFailures);
	printRelationMapping("OpenPM SRC -\> OpenPM UI", openpmUI, openpm, openpmUIInternalMapping, openpmUIInternalFailures);
	printRelationMapping("OpenPM SRC -\> Reference", project, openpm, openpmMapping, openpmFailures);
	
	printMappingUsage([
		<"Endeavour UI \\& Reference", endeavourUIMapping, endeavourUIFailures>
		, <"Endeavour SRC \\& UI", endeavourUIInternalMapping, endeavourUIInternalFailures>
		, <"Endeavour SRC \\& Reference", endeavourMapping, endeavourFailures>
		, <"OpenPM UI \\& Reference", openpmUIMapping, openpmUIFailures>
		, <"OpenPM SRC \\& UI", openpmUIInternalMapping, openpmUIInternalFailures>
		, <"OpenPM SRC \\& Reference", openpmMapping, openpmFailures>
		]);
}

public void main2() {
	println("Endeavour");
	analyseResults(endeavour, endeavourMapping, endeavourFailures);
	println("");
	println("");
	println("OpenPM");
	analyseResults(openpm, openpmMapping, openpmFailures);
	println();
	println();
	println();
	<endSim, end> = analyse(endeavour, endeavourMapping, endeavourFailures);
	<opmSim, opm> = analyse(openpm, openpmMapping, openpmFailures);
	joined = [<e, e in end<0>, e in opm<0>, end[e], opm[e]> | e <- sort([*{*end<0>, *opm<0>, *(getNameMappings(endeavourMapping)<1>), *(getNameMappings(openpmMapping)<1>)}])];
	joined = visit(joined) {
		case real x => 0.0
			when x == 0.0	
	};
	result = [<r[0], r[1], r[2], 
			r[1] ? getOneFrom(r[3])[0] : 0, r[1] ? getOneFrom(r[3])[1] : 0, r[1] ? getOneFrom(r[3])[2] : 0, r[1] ? getOneFrom(r[3])[3] : 0.0,
			r[2] ? getOneFrom(r[4])[0] : 0, r[2] ? getOneFrom(r[4])[1] : 0, r[2] ? getOneFrom(r[4])[2] : 0, r[2] ? getOneFrom(r[4])[3] : 0.0
			>
		| r <- joined
	];
	writeCSV(result, |rascal://src/results-details.csv|);
	writeFile(|rascal://src/result.tex|, ("" | it + "\\entityMapping<(""| it + "{<e>}" | e <- r)>\n" | r <- result));
	
	systems = [
		<"Endeavour", size(endeavour), size([s | /s:asso(_,_,_,_) <- endeavour]), size([s | /s:attr(_) <- endeavour])>
		, <"OpenPM", size(openpm), size([s | /s:asso(_,_,_,_) <- openpm]), size([s | /s:attr(_) <- openpm])>
		, <"Reference", size(project), size([s | /s:asso(_,_,_,_) <- project]), size([s | /s:attr(_) <- project])>
	];
	writeFile(|rascal://src/models.tex|, ("" | it + "\\modelDetails<(""| it + "{<e>}" | e <- r)>\n" | r <- systems));
	
	mappings = [
		getMappingCounts("equalName", "The target has the same entity name as the reference model")
		, getMappingCounts("synonym", "An entity in the target has another name for the same concept in the reference model")
		, getMappingCounts("extension", "An entity in the target is a broader variant of a concept in the reference model")
		, getMappingCounts("specialisation", "An entity in the target is a specialisation of a concept in the reference model")
		, getMappingCounts("implementationDetail", "An entity in the target is an implementation specific specialisation of a concept in the reference model")
		//, getMappingCounts("mappedToRelation", "An entity in the target is an relation in the reference model")
		, <"\\addlinespace Total mapped", getEntityCount(endeavourMapping), getEntityCount(openpmMapping), "">
	];
	
	mappingFailed = [
		getFailedMappingCounts("missing", "The domain entity is missing in the reference model")
		, getFailedMappingCounts("implementation", "The domain entity is an implementation detail.")
		, getFailedMappingCounts("domainDetail", "The domain entity is an detail specific to the subdomain of the target application.")
		, getFailedMappingCounts("tooDetailed", "The domain entity is too low level in compared to the reference model.")
		//, getFailedMappingCounts("differentDesign", "There is a design mismatch between the target en reference model.")
		, <"\\addlinespace Total mismapped", getEntityCount(endeavourFailures), getEntityCount(openpmFailures), "">
	];
	writeFile(|rascal://src/systems-mapping.tex|,
		("" | it + ("<m[0]>" | it + " & <r>" | r <- [i | i <- m][1..]) + "\\\\ \n" | m <- mappings)
		+ "\\midrule[0.1pt]\n" +
		("" | it + ("<m[0]>" | it + " & <r>" | r <- [i | i <- m][1..]) + "\\\\ \n" | m <- mappingFailed)
	);
}


public void checkEverythingIsMapped() {
	bool isMapped(DomainModel dm,  ModelMappings mm, ModelMappingFailures mmf) {
		ents = { c.name | Class c <- dm};
		maps =  (getMappedNames(mm) + getMappedNames(mmf));
		println((ents-maps) + (maps-ents));
		return ents == maps;
	}	
	println("endeavour: <isMapped(endeavour, endeavourMapping, endeavourFailures)>");
	println("openpm: <isMapped(openpm, openpmMapping, openpmFailures)>");
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

private tuple[str,int,int,str] getMappingCounts(str nm, str expl)
	= <nm, getMappingCount(nm, endeavourMapping), getMappingCount(nm, openpmMapping), expl>;
	
private tuple[str,int,int,str] getFailedMappingCounts(str nm, str expl)
	= <nm, getMappingCount(nm, endeavourFailures), getMappingCount(nm, openpmFailures), expl>;