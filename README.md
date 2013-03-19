This repository contains the data and scripts mentioned in the ICPC2013 submission.
We used [Rascal](http://www.rascal-mpl.org/) to analyse the systems.
This also contains a Rascal (eclipse) project.

The following structure is used: 

- ``data/facts.csv``: the 151 facts extracted from the PMBOK book.
- ``src/Reference/``: the information extracted from the PMBOK facts
	- ``Model.rsc``: Reference Model (REF).
	- ``Model.dot``: Referecen Model as a Graphviz file.
	- ``Glossary.rsc``: Glossary of project planning.
	- ``Glossary.html``: Glossary as a html table.
	- ``Process.rsc``: Process descriptions
	- ``Process.dot``: Process descriptions as a Graphviz file.
- ``src/Meta/``: The description of the meta models used.
- ``src/systems/{Endeavour,OpenPM}/``: models extracted from applications
	- ``USRModel.rsc``: Model extracted by observing UI (USR)
	- ``USRModel.dot``: USR Model as a Graphviz file.
	- ``USRModel.rsc``: USR mapped onto REF
	- ``SRCModel.rsc``: Model extracted by observing source code (SRC)
	- ``SRCModel.dot``: SRC Model as a Graphviz file.
	- ``SRCModel.rsc``: SRC mapped onto REF
	- ``INTModel.rsc``: SRC mapped onto USR
- ``src/rendering/``: Rendering a model into a graphviz file / Rascal Figure Library
- ``src/analysis/``: Scripts used to analyze the applications
- ``src/compare/``: Scripts to calculate results based on the mapping


Make sure to use the [unstable-updates](http://www.rascal-mpl.org/unstable-updates/) site to install Rascal, since that contains features used in this project.
