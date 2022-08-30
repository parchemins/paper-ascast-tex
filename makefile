
compile:
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex

camera-ready:
	mkdir -p ICA3PP22_paper_2538
	latexpand paper.tex > ICA3PP22_paper_2538/main.tex
	cp -r img ICA3PP22_paper_2538/
	rm ICA3PP22_paper_2538/img/europe_as_vs_xas.pdf
	rm ICA3PP22_paper_2538/img/europe-ases.pdf
	pdflatex ICA3PP22_paper_2538/main.tex
	bibtex main
	pdflatex -output-directory ICA3PP22_paper_2538 ICA3PP22_paper_2538/main.tex

	rm ICA3PP22_paper_2538/main.log
	rm ICA3PP22_paper_2538/main.out
	rm ICA3PP22_paper_2538/main.aux

zip:
	echo DO NOT FORGET TO INCLUDE COPYRIGHT AGREEMENTS !!!! 
	zip -r ICA3PP22_paper_2538.zip ICA3PP22_paper_2538
	rm -r ICA3PP22_paper_2538
	echo DO NOT FORGET TO INCLUDE COPYRIGHT AGREEMENTS !!!!
