module Rendering::ToGraph

import IO;
import Real;
import util::Math;
import vis::Figure;
import vis::Render;

import Meta::Domain;

private str getAttrText([]) = "";
private str getAttrText([Attribute single]) = single.name;
private default str getAttrText(list[Attribute] lst) 
	=(lst[0].name | it + "\n" + at.name | at <- lst[1..]);

private Figure getNode(Class cl) {
	str attrText = getAttrText(cl.attributes);
	if (attrText == "") {
		return vcat([box(text(cl.name, fontBold(true)), grow(1.7))], id(cl.name));
	}
	return vcat([
		box(hcat([
				space(width(10), height(1)), text(cl.name, fontBold(true)), space(width(10), height(1))
			], std(resizable(false))), hresizable(true), grow(1.3)), 
		box(hcat([
				space(width(10)), text(attrText), space(width(10))
			], std(resizable(false)), left()), hresizable(true), grow(1.1))
		]
		, resizable(false), id(cl.name));
	
}
private Figure getNode2(Class cl) {
	str attrText = getAttrText(cl.attributes);
	if (attrText == "") {
		return vcat([box(text(cl.name, fontBold(true)))], id(cl.name));
	}
	return vcat([
		box(hcat([
				space(width(10), height(1)), text(cl.name, fontBold(true)), space(width(10), height(1))
			], std(resizable(false)))), 
		box(hcat([
				space(width(10)), text(attrText), space(width(10))
			], std(resizable(false)), left()))
		]
		, id(cl.name));
	
}

public Figure diamond(int side,FProperty props...){
  return overlay([point(left(),vcenter()),point(top()), point(right(),vcenter()), point(hcenter(), bottom())], 
  	[shapeConnected(true), shapeClosed(true),  size(toReal(side)),
  	resizable(false)] + props);
}

public void renderGraph(DomainModel dom) {
	nodes = [ getNode(c)  | c <- dom];
	edges = [*[edge(c.name, asoc.otherClass, label(text(asoc.label))) | asoc <- c.assocations, c.name != asoc.otherClass] | c <- dom];
	//edges = [*[edge(c.name, asoc.otherClass, fromArrow(diamond(10))) | asoc <- c.assocations] | c <- dom];
	edges += [edge(sp.name, sp.baseClass, toArrow(triangle(10))) | sp:specialisation(_,_,_,_) <- dom];
    render(graph(nodes, edges, size(600),gap(40), hint("layered")));
}