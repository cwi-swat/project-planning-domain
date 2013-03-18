module Rendering::ToGraphviz

import IO;
import Real;
import util::Math;
import List;
import Relation;
import Set;

import Meta::Domain;


public void renderGraphviz(loc target, DomainModel model) {
	writeFile(target, toGraphviz(model));
}
public void renderGraphvizv2(loc target, DomainModel model, str params ="  nodesep=0.25;
	'	ranksep=0.5;
	'	ratio=0.7;", str font="Helvetica") {
	writeFile(target, toGraphvizv2(model, params, font));
}

private str toGraphvizv2(DomainModel model, str params, str font) {
	map[str, str] shortName = ();
	rel[str, str] sameRank = {};
	//sameRank += {*{<c.name, aso.otherClass> | aso <- c.assocations, aso@class?} | c <- model};
	sameRank += { *{<c, oc> | specialisation(oc, b, _, _) <- model, oc != c} | specialisation(c,b,_,_) <- model};
	// add reverse
	sameRank += sameRank<1,0>;
	rankClusters = sameRank+;
	
	int cCount = 0;
	for (c <- model) {
		if (!shortName[c.name]?) {
			shortName[c.name] = "c<cCount>";	
			cCount += 1;
		}
	}
	str getClass(Class c, font) {
		return "<shortName[c.name]> [label=\<<table(c)>\> fontname=\"<font>\", fontcolor=\"black\", fontsize=10.0];";
	}
	
	str getAssocation(str from, str to, str label) {
		return "<shortName[from]> -\> <shortName[to]> [label=\"<label>\"];";	
	}
	
	int assocLabelCount = 0;	
	str getAssocation(str from, str to, str label, str asso) {
		str assocLabel = "ac<assocLabelCount>";
		shortName[assocLabel] = assocLabel;
		assocLabelCount += 1;
		//style=\"invis\", fixedsize=\"true\", width=\"0\", height=\"0\"
		return "<assocLabel> [label=\"\", shape=\"circle\", width=0.01, height=0.01 ];
			'<shortName[from]> -\> <assocLabel> [label=\"<label>\", dir=\"none\"];
			'<assocLabel> -\> <shortName[to]> [label=\"\"];
		 	'<assocLabel> -\> <shortName[asso]> [label=\"<label>\", dir=\"none\", style=\"dashed\"]";	
	}
	str getSpecialisation(Class sp) {
		return "<shortName[sp.name]> -\> <shortName[sp.baseClass]> [arrowhead=\"empty\"];";	
	}
	
	str classes = "";
	todo = model;
	while (todo != {}) {
		<c, todo> = takeOneFrom(todo);	
		sameCluster = rankClusters[c.name];
		if (sameCluster != {}) {
			classes += "{ rank=same;\n";
			classes += getClass(c, font) + "\n";
			for(co <- todo, co.name in sameCluster) {
				todo -= {co};
				classes += getClass(co, font) + "\n";
			}
			classes += "}\n";
		}
		else {
			classes += getClass(c, font) + "\n";
		}
	} 
	return 
	"digraph G {
	'	edge [fontname=\"<font>\",fontsize=10,labelfontname=\"<font>\",labelfontsize=10];
	'	node [fontname=\"<font>\",fontsize=10,shape=plaintext];
	'	<params>
	'	minlen=2;
	'	rankdir=BT;
	'	<classes>
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
		return "<shortName[from]> -\> <shortName[to]> [label=\"<label>\"];";	
	}
	
	int assocLabelCount = 0;	
	str getAssocation(str from, str to, str label, str asso) {
		str assocLabel = "ac<assocLabelCount>";
		shortName[assocLabel] = assocLabel;
		assocLabelCount += 1;
		//style=\"invis\", fixedsize=\"true\", width=\"0\", height=\"0\"
		return "<assocLabel> [label=\"\", shape=\"circle\", width=0.01, height=0.01 ];
			'<shortName[from]> -\> <assocLabel> [label=\"<label>\", dir=\"none\"];
			'<assocLabel> -\> <shortName[to]> [label=\"\"];
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
	'	ratio=0.7;
	'	minlen=2;
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

public void renderGraphviz(loc target, BehaviorRelations behavior) {
	writeFile(target, toGraphviz(behavior));
}

private str toGraphviz(BehaviorRelations behavior) {
	set[str] entities = { *{"$_$" + input, "<input>$_$<name>"} |n <- behavior, str input := n[0], str name := n[1]};
	entities += { "$_$" +output |n <- behavior, n[3]?, str output := n[3]};
	entities += { "$_$" + s | n <- behavior, set[str] sources := n[2], s <- sources};
	entityList = [*entities];
	map[str, str] shortName = (entityList[n] : "e<n>" | n <- [0..size(entityList)]);
	
	str printBehavior(Behavior b) {
		if (str input := b[0], str name := b[1], str activity := b[2], str output := b[3]) {
			//either actorActivity or processActivity
			str result = "";
			if (input != "") {
				result = "<shortName["$_$" + input]> -\> <shortName[input + "$_$" + name]> [style=dashed];\n";	
			}
			return result + "<shortName[input + "$_$" + name]> -\> <shortName["$_$" + output]> [label=\"<activity>\"];";
		}
		else if (str input := b[0], str target := b[1], set[str] source := b[2]) {
			str result = "";
			if (input != "") {
				result = "<shortName["$_$" + input]> -\> <shortName[input + "$_$" + target]> [style=dashed];\n";	
			}
			return result + "<for (s <- source) {>
					'<shortName[input + "$_$" + target]> -\> <shortName["$_$" + s]> [dir=back,arrowtail=empty, style=dotted];
				'<}>
				";
		}
	}
	str getEntity (str entity) {
		if (/<i:.*>\$_\$<e:.*>/ := entity) {
			if (i == "" || "$_$<e>" notin shortName) {
				subClusters = {es |es <- shortName, /\$_\$<e>$/ := es};
				if (size(subClusters) > 1) {
					return "subgraph cluster_<shortName[entity]> {
						' style=invis;
						'	<for (es <- shortName, /\$_\$<e>$/ := es) {>
								'	<shortName[es]> [label=\"<e>\", shape=\"box\"];
						'	<}>
						}
						";
				}
				else {
					return "<shortName[entity]> [label=\"<e>\", shape=\"box\"];";
				}
			}	
		}	
		// not the "root" entity?
		return "";
	}
	
	return 
	"digraph G {
	'	edge [fontname=\"Helvetica\",fontsize=10,labelfontname=\"Helvetica\",labelfontsize=10];
	'	node [fontname=\"Helvetica\",fontsize=10,shape=plaintext];
	'	//nodesep=0.25;
	'	//ranksep=0.5;
	'	//ratio=0.95;
	'	ranksep=2.0;
	'	//minlen=2;
	'	rankdir=LR;
	'	<for (e  <- entities) {>
		'	<getEntity(e)>
	'	<}>
	'	<for (b <- behavior) {>
			<printBehavior(b)>
	'	<}>
	'}";
}