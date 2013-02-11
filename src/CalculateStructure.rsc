module CalculateStructure

import Set;
import IO;
import util::Math;
import Model::MetaDomain;
import Model::Mapping;
import Model::Simplify;
import analysis::graphs::Graph;

import Domain::Project;
import systems::endeavour::Model;
import systems::endeavour::Mapping;

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

private real calculateSimularity(set[&T] a, set[&T] b)
	= round((size(a & b) / toReal(size(a + b))) * 100)/100.0;

private void analyse(DomainModel target, ModelMappings mappings, ModelMappingFailures failures){
	<g_ref,_,_> = extractGraphs(project);
	<g_target,_,_> = extractGraphs(target);
	g_target = mapOntoReference(g_target, mappings);
	mappedNames = getNameMappings(mappings);
	e_target = (g_target<0> + g_target<1>) - ({mappedNames[f.sourceName]?f.sourceName | f <- failures} + {mappedNames[m.sourceName]?m.sourceName | m <- mappings, m has correct, !m.correct});
	g_ref += g_ref<1,0>; // make the relations undirected
	g_target += g_target<1,0>; // make the relations undirected
	for (e <- e_target) {
		assocs_ref = g_ref[e] & e_target;	
		assocs_target = g_target[e] & e_target; // also filter out missing stuff
		println(e);
		println("  assoc simularity: <calculateSimularity(assocs_ref, assocs_target) *100>");
		println("  assocs:");
		for (a <- assocs_ref) {
			println("    <a>: " + (a in assocs_target ? "\u2713": "\u2717"));	
		}
		println("  from target:");
		for (a <- assocs_target - assocs_ref) {
			println("    <a>");	
		}
	}
}

public void main() {
	analyse(endeavour, endeavourMapping, endeavourFailures);
}