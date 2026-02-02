MAIN = main
PDF = $(MAIN).pdf

all: $(PDF)

$(PDF): $(MAIN).tex sections/*.tex
	pdflatex $(MAIN).tex
	pdflatex $(MAIN).tex

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.pdf

.PHONY: all clean
