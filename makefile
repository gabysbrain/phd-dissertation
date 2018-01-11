
MAINTEX := dissertation

LATEXFLAGS=--shell-escape
LATEX=TEXINPUTS=.//: pdflatex $(LATEXFLAGS)

all:
	$(LATEX) $(MAINTEX)
	bibtex $(MAINTEX)
	$(LATEX) $(MAINTEX)
	$(LATEX) $(MAINTEX)
	$(LATEX) $(MAINTEX)
	#gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true \
		 #-sOutputFile=$(MAINTEX)_embedded.pdf -f $(MAINTEX).pdf

refs:
	bibtool /home/tom/Dropbox/Papers/all.bib -x $(MAINTEX).aux > $(MAINTEX).bib

clean:
	rm -f *.aux *.bbl *.blg *.brf *.fls *.fdb_latexmk *.lbl *.log \
	$(MAINTEX).pdf 


