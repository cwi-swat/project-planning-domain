module Model::Simplify


import analysis::graphs::Graph;
import Model::MetaDomain;

public tuple[Graph[str] assocations, rel[tuple[str,str], str] assocClasses, Graph[str] specialisations] extractGraphs(DomainModel model) {
	assocs = {*{*{<f.name,t>, <t,f.name>} | asso(_,t,_,_) <- f.assocations} | f <- model};
	assocClasses = {*{*{<<f.name,t>, a@class>, <<t,f.name>, a@class>} | a:asso(_,t,_,_) <- f.assocations, (a@class?) } | f <- model};
	specs = {<s, b> | specialisation(s, b, _, _) <- model};
	return <assocs, assocClasses, specs>;
}