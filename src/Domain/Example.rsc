module Domain::Example


import Model::MetaDomain;
import Rendering::ToGraph;


public void main() {
	DomainModel dom = {
		class("Project", 
			[attr("Name"), attr("ID")], 
			[comp("Requirements", \one(), oneOrMore(), "has")]),
		class("Requirements", [attr("ID")], [])
	};
	
	renderGraph(dom);
}