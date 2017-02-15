
EXTRA_TEX_FILES = cpr.bib mystuff.sty
# mystuff.sty
# GRAPH_FILES = xxx.pdf

all: cprtests.pdf

# mpi_io.bbl: mpi-io.bib
# 	bibtex mpi-io.bib
# bib needs cray cpr documentation and description of each program
# see reference for minga quote


# dependency might also have $(GRAPH_FILES)
cprtests.pdf:cprtests.tex $(EXTRA_TEX_FILES) acknowledge.tex
	pdflatex cprtests
	bibtex cprtests
	pdflatex cprtests
	pdflatex cprtests
