noweave -t4 headers.nw > headers.tex
noweave -t4 graph.nw > graph.tex
noweave -t4 geometrics.nw > geometrics.tex
noweave -t4 datastructures.nw > datastructures.tex
noweave -t4 bignum.nw > bignum.tex
noweave -t4 headers.nw graph.nw geometrics.nw datastructures.nw bignum.nw > content.tex

pdflatex voorblad
pdflatex content
pdftk voorblad.pdf content.pdf cat output trm.pdf

