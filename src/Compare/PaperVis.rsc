module PaperVis

import IO;
import Set;
import List;
import Node;
import Model::MetaDomain;
import Model::Mapping;
import Model::ExtractSubset;
import Rendering::ToGraphviz;
import Domain::Project;
import systems::endeavour::Model;
import systems::endeavour::UIModel;
import systems::endeavour::Mapping;
import systems::endeavour::UIMapping;
import systems::openpm::Model;
import systems::openpm::UIModel;
import systems::openpm::Mapping;
import systems::openpm::UIMapping;

public void subsetReferenceModel() {
	rl = getRelatedTo(project, "Activity", 1);
	dm = getSubset(project, rl);
	renderGraphvizv2(|rascal://src/referenceSubset.dot|, dm, params= "\tnodesep=0.2;
	'\tranksep=0.2;
	'\tratio=0.3;", font="Times");
}

public void printSizes() {
	printSizes(endeavourUI, "Endeavour");
	printSizes(endeavour, "Endeavour");
	printSizes(openpmUI, "OpenPM");
	printSizes(openpm, "OpenPM");
}

private set[str] getMappedNames(set[node] target)
	= {src | n <- target, n has sourceName, str src := getChildren(n)[0]}
		+ {*src | n <- target, n has sourceNames,  set[str] src := getChildren(n)[0] }
	;

private set[str] getMappedNamesTargets(set[node] target)
	= {src | n <- target, n has targetName, str src := getChildren(n)[1]}
	;
	
private set[str] getEntityNames(DomainModel target)
	= {src | n <- target, n has sourceName, str src := getChildren(n)[0]}
		+ {*src | n <- target, n has sourceNames,  set[str] src := getChildren(n)[0] }
	;
public void printUsageTable() {
	domainClasses = { n.name | n <- project, n has name};	
	endClasses = { n.name | n <- endeavour, n has name};	
	endUIClasses = { n.name | n <- endeavourUI, n has name};	
	opmClasses = { n.name | n <- openpm, n has name};	
	opmUIClasses = { n.name | n <- openpmUI, n has name};	
	
	endMapping = getMappedNames(endeavourMapping);
	endUIMapping = getMappedNames(endeavourUIMapping);
	opmMapping = getMappedNames(openpmMapping);
	opmUIMapping = getMappedNames(openpmUIMapping);
	
	
	mappingTargets = getMappedNamesTargets(endeavourMapping)
		+ getMappedNamesTargets(endeavourUIMapping)
		+ getMappedNamesTargets(openpmMapping)
		+ getMappedNamesTargets(openpmUIMapping)
		;
	print("\\mappingUsage{\\PMBOK}{\\REF}{");
	bool first = true;
	for (d <- sort([*domainClasses])) {
		if (!first) {
			print(",\n\t");	
		}
		first = false;
		print(d in mappingTargets ? "\\used{<d>}" : d);
	}
	println("}");
	
	print("\\mappingUsage{Endeavour}{\\USR}{");
	println("<intercalate(",\n\t", [ d in endUIMapping ? "\\inReference{<d>}" : d | d <- sort([*endUIClasses])])>");	
	println("}");
	
	print("\\mappingUsage{Endeavour}{\\SRC}{");
	println("<intercalate(",\n\t", [ d in endMapping ? "\\inReference{<d>}" : d | d <- sort([*endClasses])])>");	
	println("}");
	
	print("\\mappingUsage{OpenPM}{\\USR}{");
	println("<intercalate(",\n\t", [ d in opmUIMapping ? "\\inReference{<d>}" : d | d <- sort([*opmUIClasses])])>");	
	println("}");
	
	print("\\mappingUsage{OpenPM}{\\SRC}{");
	println("<intercalate(",\n\t", [ d in opmMapping ? "\\inReference{<d>}" : d | d <- sort([*opmClasses])])>");	
	println("}");
}


anno set[loc] node@location;
anno set[str] node@uiscreen;

private void printSizes(DomainModel dm, str name) {
	list[Attribute] emptyAttrs = [];
	dm = visit(dm) { case list[Attribute] x => emptyAttrs when x != [] };
	println("\\systemModelSize{<name>}");	
	print("\t{<size(dm)>}");
	print("{<size([a | /a:asso(_,_,_,_) := dm])>}");
	print("{<size([s | s:specialisation(_,_,_,_) <- dm])>}");
	println("{<size({*n@location | /node n := dm, n@location?} + {*n@uiscreen | /node n := dm, n@uiscreen?})>}");
}