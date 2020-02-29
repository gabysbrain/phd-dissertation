
MAINTEXS := dissertation 10_page_summary
PDFS := $(MAINTEXS:=.pdf)

LATEXFLAGS=--shell-escape
LATEX=TEXINPUTS=.//: pdflatex $(LATEXFLAGS)

.PHONY: all embedded refs clean

all: $(PDFS)

%.pdf: %.tex
	$(LATEX) $<
	bibtex $(<:.tex=)
	$(LATEX) $<
	$(LATEX) $<
	$(LATEX) $<

embedded: all
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true \
		 -sOutputFile=$(MAINTEX)_embedded.pdf -f $(MAINTEX).pdf

refs:
	bibtool /home/tom/Dropbox/Papers/all.bib -x disseration.aux > disseration.bib

%.tex: %.md
	pandoc -t latex -o $@ $<

clean:
	rm -f *.aux *.bbl *.blg *.brf *.fls *.fdb_latexmk *.loa *.lot *.lof *.lbl \
		    *.log *.toc $(PDFS)


