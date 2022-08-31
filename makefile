
compile:
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex

camera-ready:
	mkdir -p ICA3PP22_paper_2538
	latexpand paper.tex > main.tex
	cp -r img ICA3PP22_paper_2538/
	rm ICA3PP22_paper_2538/img/europe_as_vs_xas.pdf
	rm ICA3PP22_paper_2538/img/europe-ases.pdf
	cp compact_bibliographie.bib ICA3PP22_paper_2538
	pdflatex main.tex
	bibtex main
	pdflatex main.tex
	pdflatex main.tex
	mv main.tex ICA3PP22_paper_2538/
	mv main.pdf ICA3PP22_paper_2538/
	rm main.*

zip:
	echo DO NOT FORGET TO INCLUDE COPYRIGHT AGREEMENTS IN ICA3PP22 DIRECTORY !!!! 
	zip -r ICA3PP22_paper_2538.zip ICA3PP22_paper_2538
	rm -r ICA3PP22_paper_2538
	echo DO NOT FORGET TO INCLUDE COPYRIGHT AGREEMENTS IN ICA3PP22 DIRECTORY !!!!
