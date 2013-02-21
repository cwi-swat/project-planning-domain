.PHONY : FORCE_MAKE

default: report.pdf


#SOURCEBIB = ~/PhD/bibliography/PhD-report\ Engineering.bib
#
#bibliography.bib: $(SOURCEBIB)
#	cat $(SOURCEBIB) |  gsed -e '/^\s*file\s*= {[^}]*},/d' -> temp.bib # remove file references
#	bibtool -s -i "temp.bib" -o bibliography.bib # just to correct for mendeleys not sorting the keys and generating new changes in git
#	rm temp.bib
#
#update-bib: bibliography.bib
.PHONY : update-bib


report.pdf: FORCE_MAKE update-bib
	latexmk -pdf report
	rubber-info --check report
	rubber-info --boxes report

clean:
	rm -f *.log *.pdf *.ltx *_compiled.* *_latexmk
