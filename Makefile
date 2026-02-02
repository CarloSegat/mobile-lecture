CHAPTERS = $(wildcard chapters/*)
NAMES = $(notdir $(CHAPTERS))
PDFS = $(addprefix output/, $(addsuffix .pdf, $(NAMES)))

all: $(PDFS)

output/%.pdf: chapters/%/main.tex $(wildcard chapters/%/lectures/*.tex)
	cd chapters/$* && pdflatex main.tex && pdflatex main.tex
	mkdir -p output
	mv chapters/$*/main.pdf $@
	cd chapters/$* && rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb

clean:
	rm -rf output
	for dir in $(CHAPTERS); do \
		cd $$dir && rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.pdf && cd ../..; \
	done

.PHONY: all clean
