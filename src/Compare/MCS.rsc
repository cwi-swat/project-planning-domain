module Compare::MCS

/*
@article{Bunke1998255,
title = "A graph distance metric based on the maximal common subgraph",
journal = "Pattern Recognition Letters",
volume = "19",
number = "3â€“4",
pages = "255 - 259",
year = "1998",
note = "",
issn = "0167-8655",
doi = "10.1016/S0167-8655(97)00179-7",
url = "http://www.sciencedirect.com/science/article/pii/S0167865597001797",
author = "Horst Bunke and Kim Shearer",
keywords = "Error-tolerant graph matching",
keywords = "Distance measure",
keywords = "Maximal common subgraph",
keywords = "Graph edit distance",
keywords = "Metric"
}
*/

import analysis::graphs::Graph;
import util::Math;
import Set;
import Relation;
import ListRelation;
import List;
import IO;

int abs(Graph[&N] g) = size(carrier(g));

real distance(Graph[&N] g1, Graph[&N] g2) = 1.0 - 1.0 * abs(mcs(g1, g2)) / max(abs(g1), abs(g2));

int mcs(Graph[&N] g1, Graph[&N] g2) {
  m = mcs1(g1, g2);
  return isEmpty(m) ? 1 : abs(getOneFrom(m));
}

set[Graph[&N]] mcs1(Graph[&N] g1, Graph[&N] g2) {
  if(isEmpty(g1) || isEmpty(g2))
  	return {};
  common = carrier(g1) & carrier(g2);
  g1r = carrierR(g1, common);
  g2r = carrierR(g2, common);
  ginter = g1r & g2r;
  subgraphs = 
	  for(nd <- common){
	    r1 = reach(g1r, {nd});
	    r2 = reach(g2r, {nd});
	    rcommon = r1 & r2;
	    append carrierR(ginter, rcommon);
	  }
  sizes = {<abs(sb), sb> | sb <- subgraphs};
  int m = max(domain(sizes));
  return sizes[m];
}

public Graph[str] A = { <"A1", "A2">, <"A2", "A3">, <"A3", "A1">};
public Graph[str] G1 =  A + {<"B", "A1">, <"B", "A3">, <"C", "A1">, <"C", "A2">};
public Graph[str] G2 = A + {<"A1", "D">, <"D", "A3">};

test bool tst1() = mcs1(G1, G2) == {A};
test bool tst2() = distance(G1, G2) == 0.4;

test bool tst3() {
  n = 2;
  g1 = {<i, i + 1> | i <- [0 .. n]};
  g2 = g1 + {<n, n + 1>};
  return distance(g1, g2) == 1.0 - 1.0 * (n + 1) / (n + 2);
}

Graph[int] complete(Graph[int] g, int root){
   return {<root, r> | r <- top(g)} + g;
}

test bool tstmcs1(Graph[int] g1, Graph[int] g2, Graph[int] g3) {
    if(isEmpty(g1)) return true;
    g1 = complete(g1, 1);
	return g1 in mcs1(g1 + complete(g2, 2), g1 + complete(g3, 3));
}

public Graph[int] C = {<1,2>, <2,3>, <3,4>, <4,5>, <5,1>};
public Graph[int] CA = C + {<5,2>, <2,6>,<6,7>};
public Graph[int] CB = C + {<1,8>,<8,9>,<9,5>};

test bool tst1() = C in mcs1(CA, CB);
test bool tst2() = distance(CA, CB) ==  1 - 5.0/7;

public Graph[int] X = {<1,2>,<2,3>,<2,4>};

public Graph[int] XA = X + {<3,5>,<5,6>,<6,7>,<7,4>,<6,1>};

public Graph[int] XB = X + {<3,7>,<7,1>,<2,8>,<8,9>,<9,4>,<2,4>};

test bool tst1() = X in mcs1(XA, XB);
test bool tst2() = distance(XA, XB) ==  1 - 4.0/7;


Graph[int] K(int n) = {*{<i, j>| int j <- [ i + 1 .. n + 1]} | int i <- [ 1 .. n + 1 ] };

private real calculateSimularity(set[&T] a, set[&T] b)
    = round((size(a & b) / toReal(size(a + b))) * 100)/100.0;




public void compare(){
   for(m1 <- catalog)
     for(m2 <- catalog)
       if(m1 < m2 && (m1[..4] == m2[..4] || m1 == "reference" || m2 == "reference")){
          g1 = catalog[m1];  g2 = catalog[m2]; 
          println("similarity(<m1>,<m2>) = <1 - distance(g1, g2)>, jaccard: <calculateSimularity(g1, g2)>");
       }
}
