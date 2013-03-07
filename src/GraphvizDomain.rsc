module GraphvizDomain

import Rendering::ToGraphviz;
import Domain::Project;
//import systems::endeavour::Model;
import systems::openpm::Model;

public void main() {
	renderGraphvizv2(|rascal:///project.dot|, project);
	//renderGraphvizv2(|rascal:///openpm.dot|, openpm);
	//renderGraphviz(|rascal:///project-behavior.dot|, ProjectBehavior);
}