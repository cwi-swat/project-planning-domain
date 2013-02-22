module TestCrash

import vis::Figure;
import vis::Render;

// toch geen bug?
public void boxStrangeColor(bool renderGraph) {
	nodes = [
		box(hcat([box(size(20)), text("A")]), id("A"), fillColor("red")),
		box(text("B"), id("B"))
	];
	if (renderGraph) {
		edges = [edge("A", "B")];
		render(graph(nodes, edges, size(600), gap(40), hint("layered")));
	}
	else {
		render(vcat(nodes));	
	}
} 

public void multipleBoxes(int number, int selfEdges, bool withLabel) {
	nodes = [box(text("<n>"), id("<n>")) | n <- [1..number]];
	edges = [edge("<n-1>", "<n>", withLabel? label(text("<n>")): fillColor("red")) | n <- [2..number]];
	if (selfEdges > 0) {
		edges += [edge("<n>", "<n>", label(text("<n>"))) | n <- [2..(1+selfEdges)]];
	}
	edges += [edge("<number>", "1")];
	render(graph(nodes, edges, size(600), gap(40), hint("layered")));
}

public void crashWithLabel() {
	nodes = [box(text("<n>"), id("<n>")) | n <- [1..4]];
	edges = [
		//edge("1", "2")
		edge("2", "3", label(text("3")))
		//,edge("3", "4")
		//*[edge("<n-1>", "<n>", label(text("<n>"))) | n <- [2..4]]//,
		//edge("4", "1"),
		//edge("1", "1"),
		,edge("2", "2", label(text("2")))
	];
	render(graph(nodes, edges, size(600), gap(40), hint("layered")));
}


public void crashWithLabel2() {
	nodes = [
		box(text("1"), id("1")),
		box(text("2"), id("2"))
	];
	edges = [
		edge("1", "2", label(text("3"))),
		edge("1", "1", label(text("2"))) // if this is on 2,2 nothing is wrong!
	];
	render(graph(nodes, edges, size(600), gap(40), hint("layered")));
}
