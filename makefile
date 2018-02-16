
MAINTEX := dissertation

LATEXFLAGS=--shell-escape
LATEX=TEXINPUTS=.//: pdflatex $(LATEXFLAGS)

.PHONY: all embedded refs clean

all:
	$(LATEX) $(MAINTEX)
	bibtex $(MAINTEX)
	$(LATEX) $(MAINTEX)
	$(LATEX) $(MAINTEX)
	$(LATEX) $(MAINTEX)

embedded: all
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true \
		 -sOutputFile=$(MAINTEX)_embedded.pdf -f $(MAINTEX).pdf

refs:
	bibtool /home/tom/Dropbox/Papers/all.bib -x $(MAINTEX).aux > $(MAINTEX).bib

%.tex: %.md
	pandoc -t latex -o $@ $<

clean:
	rm -f *.aux *.bbl *.blg *.brf *.fls *.fdb_latexmk *.loa *.lot *.lof *.lbl \
		    *.log *.toc $(MAINTEX).pdf 


