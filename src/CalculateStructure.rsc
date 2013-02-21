module CalculateStructure

import Set;
import List;
import IO;
import util::Math;
import Model::MetaDomain;
import Model::Mapping;
import Model::Simplify;
import analysis::graphs::Graph;
import lang::csv::IO;

import Domain::Project;
import systems::endeavour::Model;
import systems::endeavour::Mapping;
import systems::openpm::Model;
import systems::openpm::Mapping;

private map[str, str] getNameMappings(ModelMappings mappings) 
	= (m.sourceName : m.targetName | m <- mappings, m has sourceName)
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

private real calculateSimularity(set[&T] a, set[&T] b)
	= round((size(a & b) / toReal(size(a + b))) * 100)/100.0;
	
private tuple[real globalsimularity, lrel[str entity, int overlap, int inreference, int intarget, real simularity] overlaps] analyse(DomainModel target, ModelMappings mappings, ModelMappingFailures failures) {
	<g_ref,_,_> = extractGraphs(project);
	<g_target,_,_> = extractGraphs(target);
	g_target = mapOntoReference(g_target, mappings);
	mappedNames = getNameMappings(mappings);
	e_target = (g_target<0> + g_target<1>) - ({mappedNames[f.sourceName]?f.sourceName | f <- failures} + {mappedNames[m.sourceName]?m.sourceName | m <- mappings, m has correct, !m.correct});
	g_ref = {<f,t> | <f,t> <- g_ref, f in e_target, t in e_target};
	g_target = {<f,t> | <f,t> <- g_target, f in e_target, t in e_target};
	g_ref += g_ref<1,0>; // make the relations undirected
	g_target += g_target<1,0>; // make the relations undirected
	return <calculateSimularityUndirected(g_ref, g_target),
		[<e, size(g_ref[e] & g_target[e]), size(g_ref[e]), size(g_target[e]), calculateSimularity(g_ref[e], g_target[e])>
			| e <- sort([*e_target])]
		>;
}

private void analyseResults(DomainModel target, ModelMappings mappings, ModelMappingFailures failures){
	<total, details> = analyse(target, mappings, failures);
	println("total simularity: <total *100>");
	for (<e, overlap, _,_, s>  <- details) {
		println(" <e>: <s*100> (<overlap>)");
	}
}

public void main() {
	println("Endeavour");
	analyseResults(endeavour, endeavourMapping, endeavourFailures);
	println("");
	println("");
	println("OpenPM");
	analyseResults(openpm, openpmMapping, openpmFailures);
	println();
	println();
	println();
	<_, end> = analyse(endeavour, endeavourMapping, endeavourFailures);
	<_, opm> = analyse(openpm, openpmMapping, openpmFailures);
	joined = [<e, e in end<0>, e in opm<0>, end[e], opm[e]> | e <- sort([*{*end<0>, *opm<0>}])];
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
		<"Endeavour", size(endeavour), size(endeavourMapping), size({x | x <- endeavourFailures, x is missed}), size({x | x <- endeavourFailures, x is implementation})>,
		<"OpenPM", size(openpm), size(openpmMapping), size({x | x <- openpmFailures, x is missed}), size({x | x <- openpmFailures, x is implementation})>
	];
	writeFile(|rascal://src/systems.tex|, ("" | it + "\\systemDetails<(""| it + "{<e>}" | e <- r)>\n" | r <- systems));
}