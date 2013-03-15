module Reference::Facts

import lang::csv::IO;

alias Facts = rel[int id, int source, int page, str fact];

public Facts readFacts() = readCSV(#Facts, |project://projectdomain/data/facts.csv|, ("separator" :";"));

public void writeFacts(Facts fs, loc target) {
	writeCSV(fs, target, ("separator": ";"));
}