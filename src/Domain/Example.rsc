module Domain::Example


import Model::MetaDomain;
import Rendering::ToGraph;


public void main() {
	DomainModel dom = {
		class("Project", 
			[attr("Name"), attr("ID")], 
			[asso("has", "Requirements", \one(), oneOrMore()),
			 asso("has", "Goal", \one(), oneOrMore()),
			 asso("consists-of", "Iteration", \one(), oneOrMore()),
			 asso("influenced-by", "Environment", \one(), noneOrMore())
			]),
		class("Requirements", [attr("ID")], []),
		class("Goal", [], []),
		class("Iteration", [], 
			[asso("results-in", "Increment", oneOrMore(), oneOrMore()),
			 asso("targets", "Goal", oneOrMore(), oneOrMore())
			]),
		class("Environment", [],[]),	
		specialisation("Increment", "Result", [], []),
		class("Result", [],[])
	};
	
	renderGraph(dom);
}