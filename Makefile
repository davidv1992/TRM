.PHONY: clean test_mf test_mt test_sp test_ts test
.DEFAULT_GOAL := trm.pdf
SHELL := /bin/bash
CXXFLAGS := -g -Wall -Wextra -Wno-unused-result -Wno-sign-compare

trm.pdf: Makefile voorblad.pdf content.pdf
	pdftk voorblad.pdf content.pdf cat output trm.pdf

voorblad.pdf: Makefile voorblad.tex
	pdflatex voorblad

content.pdf: Makefile content.tex
	pdflatex content

content.tex: Makefile headers.nw debug.nw graph.nw geometrics.nw datastructures.nw bignum.nw
	noweave -t4 headers.nw debug.nw graph.nw geometrics.nw datastructures.nw bignum.nw > content.tex

test: test_mf test_mt test_sp test_ts test_mfs bignum grahamscan polygon_area hungarian
	echo Please manually test bignum, hungarian, polygon_area and grahamscan
	
test_mf: test_mf.sh mf_testgen maxflow maxflow2
	./test_mf.sh
	
test_mfs: test_mfs.sh mfs_testgen maxflow maxflow3
	./test_mfs.sh

test_mt: test_mt.sh mt_testgen minspan minspan2
	./test_mt.sh

test_sp: test_sp.sh sp_testgen dijkstras bellmanford floydwarshall
	./test_sp.sh

test_ts: test_ts.sh ts_testgen 2sat
	./test_ts.sh

mt_testgen: mt_testgen.cpp
	g++ -o mt_testgen mt_testgen.cpp $(CXXFLAGS)

sp_testgen: sp_testgen.cpp
	g++ -o sp_testgen sp_testgen.cpp $(CXXFLAGS)

ts_testgen: ts_testgen.cpp
	g++ -o ts_testgen ts_testgen.cpp $(CXXFLAGS)

mf_testgen: mf_testgen.cpp
	g++ -o mf_testgen mf_testgen.cpp $(CXXFLAGS)

mfs_testgen: mfs_testgen.cpp
	g++ -o mfs_testgen mfs_testgen.cpp $(CXXFLAGS)

2sat.cpp: Makefile headers.nw graph.nw graph_test.nw datastructures.nw
	notangle -L -R2sat.cpp headers.nw graph.nw graph_test.nw datastructures.nw > 2sat.cpp

2sat: 2sat.cpp
	g++ -o 2sat 2sat.cpp $(CXXFLAGS)

dijkstras.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rdijkstras.cpp headers.nw graph.nw graph_test.nw > dijkstras.cpp

dijkstras: dijkstras.cpp
	g++ -o dijkstras dijkstras.cpp $(CXXFLAGS)

bellmanford.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rbellmanford.cpp headers.nw graph.nw graph_test.nw > bellmanford.cpp

bellmanford: bellmanford.cpp
	g++ -o bellmanford bellmanford.cpp $(CXXFLAGS)

minspan.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rminspan.cpp headers.nw graph.nw graph_test.nw > minspan.cpp

minspan: minspan.cpp
	g++ -o minspan minspan.cpp $(CXXFLAGS)

minspan2.cpp: Makefile headers.nw graph_test.nw datastructures.nw
	notangle -L -Rminspan2.cpp headers.nw graph_test.nw datastructures.nw > minspan2.cpp

minspan2: minspan2.cpp
	g++ -o minspan2 minspan2.cpp $(CXXFLAGS)

maxflow.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rmaxflow.cpp headers.nw graph.nw graph_test.nw > maxflow.cpp

maxflow: maxflow.cpp
	g++ -o maxflow maxflow.cpp $(CXXFLAGS)

maxflow3.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rmaxflow3.cpp headers.nw graph.nw graph_test.nw > maxflow3.cpp

maxflow3: maxflow3.cpp
	g++ -o maxflow3 maxflow3.cpp $(CXXFLAGS)

maxflow2: maxflow2.cpp
	g++ -o maxflow2 maxflow2.cpp $(CXXFLAGS)

floydwarshall.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rfloydwarshall.cpp headers.nw graph.nw graph_test.nw > floydwarshall.cpp

floydwarshall: floydwarshall.cpp
	g++ -o floydwarshall floydwarshall.cpp $(CXXFLAGS)

hungarian.cpp: Makefile headers.nw graph.nw graph_test.nw
	notangle -L -Rhungarian.cpp headers.nw graph.nw graph_test.nw > hungarian.cpp

hungarian: hungarian.cpp
	g++ -o hungarian hungarian.cpp $(CXXFLAGS)
	
bignum.cpp: Makefile headers.nw bignum.nw bignum_test.nw
	notangle -L -Rbignum.cpp headers.nw bignum.nw bignum_test.nw > bignum.cpp

bignum: bignum.cpp
	g++ -o bignum bignum.cpp $(CXXFLAGS)

grahamscan.cpp: Makefile headers.nw geometrics.nw geometrics_test.nw
	notangle -L -Rgrahamscan.cpp headers.nw geometrics.nw geometrics_test.nw > grahamscan.cpp

grahamscan: grahamscan.cpp
	g++ -o grahamscan grahamscan.cpp `pkg-config --cflags --libs cairo` $(CXXFLAGS)

polygon_area.cpp: Makefile headers.nw geometrics.nw geometrics_test.nw
	notangle -L -Rpolygon_area.cpp headers.nw geometrics.nw geometrics_test.nw > polygon_area.cpp

polygon_area: polygon_area.cpp
	g++ -o polygon_area polygon_area.cpp $(CXXFLAGS)

matrixmul.cpp: Makefile headers.nw matrix.nw matrix_test.nw
	notangle -L -Rmatrixmul.cpp headers.nw matrix.nw matrix_test.nw > matrixmul.cpp

matrixmul: matrixmul.cpp
	g++ -o matrixmul matrixmul.cpp $(CXXFLAGS)

clean:
	rm -f *.pdf *.aux *.log
	rm -f voorblad.pdf content.pdf trm.pdf content.tex
	rm -f 2sat.cpp bellmanford.cpp bignum.cpp
	rm -f dijkstras.cpp floydwarshall.cpp grahamscan.cpp
	rm -f hungarian.cpp maxflow.cpp minspan.cpp minspan2.cpp
	rm -f polygon_area.cpp maxflow3.cpp matrixmul.cpp
	rm -f 2sat bellmanford bignum dijkstras floydwarshall
	rm -f grahamscan hungarian maxflow maxflow2 minspan
	rm -f minspan2 polygon_area maxflow3 matrixmul
	rm -f mt_testgen sp_testgen ts_testgen mf_testgen mfs_testgen
	
