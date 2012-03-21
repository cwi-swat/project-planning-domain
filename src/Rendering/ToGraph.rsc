module Rendering::ToGraph


import vis::Figure;
import vis::Render;

import Model::MetaDomain;

private str getAttrText([]) = "";
private str getAttrText([Attribute first, list[Attribute] rest]) = (first.name | it + "\n" + at.name | at <- rest);

private Figure getNode(Class cl) {
	str attrText = getAttrText(cl.attributes);
	if (attrText == "") {
		return vcat([box(text(cl.name, fontBold(true)), grow(1.3))], id(cl.name));
	}
	return box(vcat([text(cl.name, fontBold(true), grow(1.2)),  text(attrText, grow(1.2))]), id(cl.name));
	
}

public void renderGraph(DomainModel dom) {
	nodes = [ getNode(c)  | c <- dom];
	Edges emptyToAvoidRascalBug = [];
	edges = [*(emptyToAvoidRascalBug + [edge(c.name, asoc.otherClass, label(text(asoc.label))) | asoc <- c.assocations]) | c <- dom];
	edges += [edge(sp.name, sp.baseClass, toArrow(triangle(10))) | sp:specialisation(_,_,_,_) <- dom];
    render(graph(nodes, edges, size(600),gap(40)));
}