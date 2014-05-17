# TBH Makefile

all: pdf html

.INTERMEDIATE:  cv.texml
.SECONDARY:  cv.texml
.PHONY: pdf html 

pdf: cv.pdf
html: cv.html

%.pdf: %.tex
	latexmk -pdf $*

clean_tex= \
	rm -f `ls $(1)* | grep -ve "$(1)\.\(pdf\|bst\|bib\|tex\|synctex.gz\)$$"`

%.tex: %.texml
	rm -f $@
	texml.py -e UTF-8 $^ $@
	sed -i "s/\r//g" $@


%.texml: %.tex.xsl %.xml
	xsltproc $^ > $@

%.html: %.xsl %.xml
	xsltproc $^ > $@

clean:
	-rm -r auto
	$(call clean_tex,cv)

