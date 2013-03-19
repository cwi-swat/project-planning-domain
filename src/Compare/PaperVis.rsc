module Compare::PaperVis

import IO;
import Set;
import List;
import Node;
import Meta::Domain;
import Meta::Mapping;
import Rendering::ToGraphviz;
import Reference::Model;
import systems::endeavour::SRCModel;
import systems::endeavour::USRModel;
import systems::endeavour::SRCMapping;
import systems::endeavour::USRMapping;
import systems::openpm::SRCModel;
import systems::openpm::USRModel;
import systems::openpm::SRCMapping;
import systems::openpm::USRMapping;


public void printSizes() {
	printSizes(endeavourUSR, "Endeavour");
	printSizes(endeavourSRC, "Endeavour");
	printSizes(openpmUSR, "OpenPM");
	printSizes(openpmSRC, "OpenPM");
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
	domainClasses = { n.name | n <- Reference, n has name};	
	endClasses = { n.name | n <- endeavourSRC, n has name};	
	endUIClasses = { n.name | n <- endeavourUSR, n has name};	
	opmClasses = { n.name | n <- openpmSRC, n has name};	
	opmUIClasses = { n.name | n <- openpmUSR, n has name};	
	
	endMapping = getMappedNames(endeavourSRCMapping);
	endUIMapping = getMappedNames(endeavourUSRMapping);
	opmMapping = getMappedNames(openpmSRCMapping);
	opmUIMapping = getMappedNames(openpmUSRMapping);
	
	
	mappingTargets = getMappedNamesTargets(endeavourSRCMapping)
		+ getMappedNamesTargets(endeavourUSRMapping)
		+ getMappedNamesTargets(openpmSRCMapping)
		+ getMappedNamesTargets(openpmUSRMapping)
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
	print("{<size([a | /a:asso(_,_) := dm])>}");
	print("{<size([s | s:specialisation(_,_,_,_) <- dm])>}");
	println("{<size({*n@location | /node n := dm, n@location?} + {*n@uiscreen | /node n := dm, n@uiscreen?})>}");
}