.PHONY: clean test_mf test_mt test_sp test_ts test
.DEFAULT_GOAL := trm.pdf
SHELL := /bin/bash

trm.pdf: Makefile voorblad.pdf content.pdf
	pdftk voorblad.pdf content.pdf cat output trm.pdf

voorblad.pdf: Makefile voorblad.tex
	pdflatex voorblad

content.pdf: Makefile content.tex
	pdflatex content

content.tex: Makefile headers.nw graph.nw geometrics.nw datastructures.nw bignum.nw
	noweave -t4 headers.nw graph.nw geometrics.nw datastructures.nw bignum.nw > content.tex

test: test_mf test_mt test_sp test_ts bignum grahamscan polygon_area hungarian
	echo Please manually test bignum, hungarian, polygon_area and grahamscan
	
test_mf: test_mf.sh mf_testgen maxflow maxflow2
	./test_mf.sh

test_mt: test_mt.sh mt_testgen minspan minspan2
	./test_mt.sh

test_sp: test_sp.sh sp_testgen dijkstras bellmanford floydwarshall
	./test_sp.sh

test_ts: test_ts.sh ts_testgen 2sat
	./test_ts.sh

mt_testgen: mt_testgen.cpp
	g++ -o mt_testgen mt_testgen.cpp -O2 -Wall -Wextra

sp_testgen: sp_testgen.cpp
	g++ -o sp_testgen sp_testgen.cpp -O2 -Wall -Wextra

ts_testgen: ts_testgen.cpp
	g++ -o ts_testgen ts_testgen.cpp -O2 -Wall -Wextra

mf_testgen: mf_testgen.cpp
	g++ -o mf_testgen mf_testgen.cpp -O2 -Wall -Wextra

2sat.cpp: Makefile headers.nw graph.nw graph_test.nw datastructures.nw
	notangle -L -R2sat.cpp headers.nw graph.nw graph_test.nw datastructures.nw > 2sat.cpp

2sat: 2sat.cpp
	g++ -o 2sat 2sat.cpp -O2 -Wall -Wextra

dijkstras.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rdijkstras.cpp headers.nw graph.nw graph_test.nw > dijkstras.cpp

dijkstras: dijkstras.cpp
	g++ -o dijkstras dijkstras.cpp -O2 -Wall -Wextra

bellmanford.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rbellmanford.cpp headers.nw graph.nw graph_test.nw > bellmanford.cpp

bellmanford: bellmanford.cpp
	g++ -o bellmanford bellmanford.cpp -O2 -Wall -Wextra

minspan.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rminspan.cpp headers.nw graph.nw graph_test.nw > minspan.cpp

minspan: minspan.cpp
	g++ -o minspan minspan.cpp -O2 -Wall -Wextra

minspan2.cpp: Makefile headers.nw graph_test.nw datastructures.nw
	notangle -L -Rminspan2.cpp headers.nw graph_test.nw datastructures.nw > minspan2.cpp

minspan2: minspan2.cpp
	g++ -o minspan2 minspan2.cpp -O2 -Wall -Wextra

maxflow.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rmaxflow.cpp headers.nw graph.nw graph_test.nw > maxflow.cpp

maxflow: maxflow.cpp
	g++ -o maxflow maxflow.cpp -O2 -Wall -Wextra

maxflow2: maxflow2.cpp
	g++ -o maxflow2 maxflow2.cpp -O2 -Wall -Wextra

floydwarshall.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rfloydwarshall.cpp headers.nw graph.nw graph_test.nw > floydwarshall.cpp

floydwarshall: floydwarshall.cpp
	g++ -o floydwarshall floydwarshall.cpp -O2 -Wall -Wextra

hungarian.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rhungarian.cpp headers.nw graph.nw graph_test.nw > hungarian.cpp

hungarian: hungarian.cpp
	g++ -o hungarian hungarian.cpp -O2 -Wall -Wextra
	
bignum.cpp: Makefile headers.nw bignum.nw bignum_test.nw
	notangle -L -Rbignum.cpp headers.nw bignum.nw bignum_test.nw > bignum.cpp

bignum: bignum.cpp
	g++ -o bignum bignum.cpp -O2 -Wall -Wextra

grahamscan.cpp: Makefile headers.nw geometrics.nw geometrics_test.nw
	notangle -L -Rgrahamscan.cpp headers.nw geometrics.nw geometrics_test.nw > grahamscan.cpp

grahamscan: grahamscan.cpp
	g++ -o grahamscan grahamscan.cpp `pkg-config --cflags --libs cairo` -O2 -Wall -Wextra

polygon_area.cpp: Makefile headers.nw geometrics.nw geometrics_test.nw
	notangle -L -Rpolygon_area.cpp headers.nw geometrics.nw geometrics_test.nw > polygon_area.cpp

polygon_area: polygon_area.cpp
	g++ -o polygon_area polygon_area.cpp -O2 -Wall -Wextra

clean:
	rm -f *.pdf *.aux *.log
	rm -f voorblad.pdf content.pdf trm.pdf content.tex
	rm -f 2sat.cpp bellmanford.cpp bignum.cpp
	rm -f dijkstras.cpp floydwarshall.cpp grahamscan.cpp
	rm -f hungarian.cpp maxflow.cpp minspan.cpp minspan2.cpp
	rm -f polygon_area.cpp
	rm -f 2sat bellmanford bignum dijkstras floydwarshall
	rm -f grahamscan hungarian maxflow maxflow2 minspan
	rm -f minspan2 polygon_area
	rm -f mt_testgen sp_testgen ts_testgen mf_testgen
	
