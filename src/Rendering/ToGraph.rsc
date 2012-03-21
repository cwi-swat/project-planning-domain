module Rendering::ToGraph


import vis::Figure;
import vis::Render;

import Model::MetaDomain;

private str getAttrText([]) = "";
private str getAttrText([Attribute first, list[Attribute] rest]) = (first.name | it + "\n" + at.name | at <- rest);

public void renderGraph(DomainModel dom) {
	nodes = [ vcat([box(text(c.name), grow(1.1)), box(text( getAttrText(c.attributes)))], id(c.name))  | c <- dom];
	Edges emptyToAvoidRascalBug = [];
	edges = [*(emptyToAvoidRascalBug + [edge(c.name, asoc.otherClass) | asoc <- c.assocations]) | c <- dom];
    render(graph(nodes, edges, size(400),gap(40)));
}