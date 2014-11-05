.PHONY: clean
.DEFAULT_GOAL := trm.pdf

trm.pdf: Makefile voorblad.pdf content.pdf
	pdftk voorblad.pdf content.pdf cat output trm.pdf

voorblad.pdf: Makefile voorblad.tex
	pdflatex voorblad

content.pdf: Makefile content.tex
	pdflatex content

content.tex: Makefile headers.nw graph.nw geometrics.nw datastructures.nw bignum.nw
	noweave -t4 headers.nw graph.nw geometrics.nw datastructures.nw bignum.nw > content.tex

clean:
	rm -f voorblad.pdf content.pdf trm.pdf content.tex
