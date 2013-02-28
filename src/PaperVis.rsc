module PaperVis

import IO;
import Set;
import List;
import Model::MetaDomain;
import Model::ExtractSubset;
import Rendering::ToGraphviz;
import Domain::Project;
import systems::endeavour::Model;
import systems::openpm::Model;

public void subsetReferenceModel() {
	rl = getRelatedTo(project, "Deliverable", 1);
	dm = getSubset(project, rl);
	renderGraphvizv2(|rascal://src/referenceSubset.dot|, dm, params= "\tnodesep=0.2;
	'\tranksep=0.2;
	'\tratio=0.3;", font="Times");
}

public void printSizes() {
	printSizes(endeavour, "Endeavour");
	printSizes(openpm, "OpenPM");
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