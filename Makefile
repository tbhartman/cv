# TBH Makefile

all: pdf html

.SECONDARY:  cv.texml
.PHONY: pdf html 

pdf: cv.pdf
html: cv.html

%.pdf: %.tex
	latexmk -pdf $*

%.tex: %.texml
	rm -f $@
	texml -e UTF-8 $^ $@
	sed -i "s/\r//g" $@


%.texml: %.tex.xsl %.xml
	xsltproc $^ > $@

%.html: %.xsl %.xml
	xsltproc $^ > $@

clean:
	latexmk -c cv

