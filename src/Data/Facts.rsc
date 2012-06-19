module Data::Facts

import lang::csv::IO;

alias Facts = rel[int id, int source, int page, str fact];

public Facts readFacts() = readCSV(#Facts, |project://projectdomain/src/Data/facts.csv|, ("separator" :";"));