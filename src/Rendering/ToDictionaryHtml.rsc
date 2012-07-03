module Rendering::ToDictionaryHtml

import IO;
import Real;
import Integer;
import List;
import Set;

import Data::Facts;
import Model::MetaDomain;

private str tb(str s) = "\<<s>\>";
private str te(str s) = "\</<s>\>";
private str makeRow(list[str] dt) = "<tb("tr")><for (d <- dt){><tb("td")><d><te("td")><}><te("tr")>";
private str makeList(list[str] ls) =
	"<tb("ul")>
	'	<for(l <- ls) {>
		'	<tb("li")><l><te("li")>
	'	<}>
	'<te("ul")>";

public void renderDictionaryHtml(loc target, Dictionary dictionary) {
	sortedDictionary = sort(toList(dictionary), bool (term(a,_), term(b,_)) { return a > b; });
	facts = readFacts();
	writeFile(target, 
		"<tb("html")>
		'	<tb("head")>
		'		<tb("title")>Dictionary<te("title")>
		'	<te("head")>
		'	<tb("body")>
		'		<tb("table")>
		'			<tb("thead")>
		'				<makeRow(["Term", "Description"])>
		'			<te("thead")>
		'			<tb("tbody")>
		'			<for(dt <- sortedDictionary) {>
		'				<makeRow([dt.name, makeList(sort(toList((facts<0,3>)[dt.descriptions])))])>
		'			<}>
		'			<te("tbody")>
		'		<te("table")>
		'	<te("body")>
		'<te("html")>
		"); 
}

