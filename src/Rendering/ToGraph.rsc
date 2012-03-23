module Rendering::ToGraph

import Real;
import Integer;
import vis::Figure;
import vis::Render;

import Model::MetaDomain;

private str getAttrText([]) = "";
private str getAttrText([Attribute first, list[Attribute] rest]) = (first.name | it + "\n" + at.name | at <- rest);

private Figure getNode(Class cl) {
	str attrText = getAttrText(cl.attributes);
	if (attrText == "") {
		return vcat([box(text(cl.name, fontBold(true)), grow(1.7))], id(cl.name));
	}
	return vcat([
		box(hcat([
				space(width(10), height(1)), text(cl.name, fontBold(true)), space(width(10), height(1))
			], std(resizable(false))), resizable(true)), 
		box(hcat([
				space(width(10)), text(attrText), space(width(10))
			], std(resizable(false)), left()), resizable(true))
		]
		, resizable(false), id(cl.name));
	
}

public Figure diamond(int side,FProperty props...){
  return overlay([point(left(),vcenter()),point(top()), point(right(),vcenter()), point(hcenter(), bottom())], 
  	[shapeConnected(true), shapeClosed(true),  size(toReal(side)),
  	resizable(false)] + props);
}

public void renderGraph(DomainModel dom) {
	nodes = [ getNode(c)  | c <- dom];
	Edges emptyToAvoidRascalBug = [];
	edges = [*(emptyToAvoidRascalBug + [edge(c.name, asoc.otherClass, fromArrow(diamond(10)), label(text(asoc.label))) | asoc <- c.assocations]) | c <- dom];
	edges += [edge(sp.name, sp.baseClass, toArrow(triangle(10))) | sp:specialisation(_,_,_,_) <- dom];
    render(graph(nodes, edges, size(600),gap(40), hint("layered")));
}