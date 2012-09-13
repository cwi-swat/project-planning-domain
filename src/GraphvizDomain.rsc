module GraphvizDomain

import Rendering::ToGraphviz;
import Domain::Project;

public void main() {
	renderGraphvizv2(|rascal:///project.dot|, project);
	renderGraphviz(|rascal:///project-behavior.dot|, ProjectBehavior);
}