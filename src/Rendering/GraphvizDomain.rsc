module Rendering::GraphvizDomain

import Rendering::ToGraphviz;
import Rendering::ToDictionaryHtml;

import Reference::Model;
import Reference::Glossary;
import Reference::Process;

import systems::endeavour::USRModel;
import systems::endeavour::SRCModel;
import systems::openpm::USRModel;
import systems::openpm::SRCModel;

public void main() {
	renderGraphvizv2(|rascal:///Reference/Model.dot|, Reference);
	renderGraphvizv2(|rascal:///systems/endeavour/USRModel.dot|, endeavourUSR);
	renderGraphvizv2(|rascal:///systems/endeavour/SRCModel.dot|, endeavourSRC);
	renderGraphvizv2(|rascal:///systems/openpm/USRModel.dot|, openpmUSR);
	renderGraphvizv2(|rascal:///systems/openpm/SRCModel.dot|, openpmSRC);
	renderDictionaryHtml(|rascal:///Reference/Glossary.html|, ReferenceGlossary);
	renderGraphviz(|rascal:///Reference/Process.dot|, ProjectBehavior);
}