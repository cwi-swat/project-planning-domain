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
import systems::endeavour::Mapping;
import systems::openpm::Model;
import systems::openpm::Mapping;

public void subsetReferenceModel() {
	rl = getRelatedTo(project, "Activity", 1);
	dm = getSubset(project, rl);
	renderGraphvizv2(|rascal://src/referenceSubset.dot|, dm, params= "\tnodesep=0.2;
	'\tranksep=0.2;
	'\tratio=0.3;", font="Times");
}

public void printSizes() {
	printSizes(endeavour, "Endeavour");
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
	opmClasses = { n.name | n <- openpm, n has name};	
	endMapping = getMappedNames(endeavourMapping);
	endMappingTargets = getMappedNamesTargets(endeavourMapping);
	opmMapping = getMappedNames(openpmMapping);
	opmMappingTargets = getMappedNamesTargets(openpmMapping);
	print("\\mappingUsage{Reference}{");
	bool first = true;
	for (d <- sort([*domainClasses])) {
		s = d;
		if (d in endMappingTargets) {
			s = "\\inEndeavour{<s>}";	
		}
		if (d in opmMappingTargets) {
			s = "\\inOpenPM{<s>}";	
		}
		if (!first) {
			print(",\n\t");	
		}
		first = false;
		print(s);
	}
	println("}");
	
	print("\\mappingUsage{Endeavour}{");
	println("<intercalate(",\n\t", [ d in endMapping ? "\\inReference{<d>}" : d | d <- sort([*endClasses])])>");	
	println("}");
	
	print("\\mappingUsage{OpenPM}{");
	println("<intercalate(",\n\t", [ d in opmMapping ? "\\inReference{<d>}" : d | d <- sort([*opmClasses])])>");	
	println("}");
}


anno set[loc] node@location;

private void printSizes(DomainModel dm, str name) {
	println("\\systemModelSize{<name>}");	
	print("\t{<size(dm)>}");
	print("{<size([a | /a:asso(_,_,_,_) := dm])>}");
	print("{<size([s | s:specialisation(_,_,_,_) <- dm])>}");
	print("{<size([a | /a:attr(_) := dm])>}");
	println("{<size({*n@location | /node n := dm, n@location?})>}");
}