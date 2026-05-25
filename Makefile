# Makefile — build Shizheng Wen's CV
#   make        compile shizheng-wen-cv.tex -> shizheng-wen-cv.pdf (pdfLaTeX, run twice)
#   make clean  remove auxiliary files (keeps the .pdf)

TEX        = shizheng-wen-cv
LATEX      = pdflatex
LATEXFLAGS = -interaction=nonstopmode -halt-on-error

.PHONY: all clean

all: $(TEX).pdf

$(TEX).pdf: $(TEX).tex
	$(LATEX) $(LATEXFLAGS) $(TEX).tex
	$(LATEX) $(LATEXFLAGS) $(TEX).tex

clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot *.synctex.gz *.fdb_latexmk *.fls
