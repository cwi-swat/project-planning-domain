module Rendering::ToGraphviz

import IO;
import Real;
import Integer;
import List;

import Model::MetaDomain;


public void renderGraphviz(loc target, DomainModel model) {
	writeFile(target, toGraphviz(model));
}

private str table(Class c) {
	return 
	"\<table border=\"0\" cellborder=\"1\" cellspacing=\"0\" cellpadding=\"2\" port=\"p\"\>" 
		+ "\<tr\>\<td\><c.name>\</td\>\</tr\>"
		+ (c.attributes == [] ? "" : (
			"\<tr\>\<td balign=\"left\" align=\"left\"\>" + ("+" + head(c.attributes).name | it + "\<br /\>+" + a.name | a <- tail(c.attributes)) + "\</td\>\</tr\>"))
	+ "\</table\>";
}

private str toGraphviz(DomainModel model) {
	map[str, str] shortName = ();
	int cCount = 0;
	for (c <- model) {
		if (!shortName[c.name]?) {
			shortName[c.name] = "c<cCount>";	
			cCount += 1;
		}
	}
	str getClass(Class c) {
		return "<shortName[c.name]> [label=\<<table(c)>\> fontname=\"Helvetica\", fontcolor=\"black\", fontsize=10.0];";
	}
	
	str getAssocation(str from, str to, str label) {
		return "<shortName[from]> -\> <shortName[to]> [label=\"<label>\", dir=\"none\"];";	
	}
	
	int assocLabelCount = 0;	
	str getAssocation(str from, str to, str label, str asso) {
		str assocLabel = "ac<assocLabelCount>";
		shortName[assocLabel] = assocLabel;
		assocLabelCount += 1;
		return "<assocLabel> [label=\"\", style=\"invis\", fixedsize=\"true\", width=\"0\", height=\"0\"];
			'<getAssocation(from, assocLabel, label)>
			'<getAssocation(assocLabel, to, "")>
		 	'<assocLabel> -\> <shortName[asso]> [label=\"<label>\", dir=\"none\", style=\"dashed\"]";	
	}
	str getSpecialisation(Class sp) {
		return "<shortName[sp.name]> -\> <shortName[sp.baseClass]> [arrowhead=\"empty\"];";	
	}
	
	return 
	"digraph G {
	'	edge [fontname=\"Helvetica\",fontsize=10,labelfontname=\"Helvetica\",labelfontsize=10];
	'	node [fontname=\"Helvetica\",fontsize=10,shape=plaintext];
	'	nodesep=0.25;
	'	ranksep=0.5;
	'	rankdir=BT;
	'	<for (Class c <- model) {>
		'	<getClass(c)>
	'	<}>
	'	// regular assocations
	'	<for (<f,t,l> <- [*[<c.name, aso.otherClass, aso.label> | aso <- c.assocations, !aso@class?] | c <- model]) { >
		'	<getAssocation(f,t, l)>	
	'	<}>
	'	// assocations with classes on them
	'	<for (<f,t,l, c> <- [*[<c.name, aso.otherClass, aso.label, aso@class> | aso <- c.assocations, aso@class?] | c <- model]) { >
		'	<getAssocation(f,t, l, c)>	
	'	<}>
	'	<for (sp:specialisation(_,_,_,_) <- model) {>
		'	<getSpecialisation(sp)>
	'	<}>
	'}";
}
