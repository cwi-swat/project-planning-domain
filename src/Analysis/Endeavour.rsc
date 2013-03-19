module Analysis::Endeavour

import String;
import util::Resources;
import lang::java::jdt::JDT;
import lang::java::jdt::Java;
import lang::java::jdt::JavaADT;
import util::Resources;


import Analysis::Generic;

//private list[Id] modelOnly = [package("org"),package("tracka")];
private list[Id] modelOnly = [package("org"),package("endeavour"),package("mgmt"),package("model")];
public list[Id] viewOnly = [package("org"),package("endeavour"),package("mgmt"),package("view")];

private bool isModelEntity(Entity c) = entity([*modelOnly,_*, cl,_*]) := c 
	&& (class(_) := cl || class(_,_) := cl || interface(_) := cl || interface(_,_) := cl || enum(_) := cl)
	&& (cl has name ==> !endsWith(cl.name, "Test") );
	
private bool isViewEntity(Entity c) = entity([*viewOnly,_*, cl,_*]) := c 
	&& (class(_) := cl || class(_,_) := cl || interface(_) := cl || interface(_,_) := cl || enum(_) := cl)
	&& (cl has name ==> !endsWith(cl.name, "Test") );
	
private str printable(Entity e) {
	return readable(entity(e.id - modelOnly));
}

private void setupGeneric() {
	SetupGeneric(|project://Endeavour-Mgmt|, isModelEntity, isViewEntity, printable , modelOnly);
}

public void main() {
	setupGeneric();
	visualizeDomainLinks2();
	listInterestingViewMethods();
}