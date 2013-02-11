module GraphvizDomain

import Rendering::ToGraphviz;
import Domain::Project;
import systems::endeavour::Model;

public void main() {
	renderGraphvizv2(|rascal:///project.dot|, project);
	renderGraphvizv2(|rascal:///endeavour.dot|, endeavour);
	//renderGraphviz(|rascal:///project-behavior.dot|, ProjectBehavior);
}