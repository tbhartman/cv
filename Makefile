# TBH Makefile

all: pdf html

.SECONDARY:  cv.texml cv.html
.PHONY: pdf html 

pdf: cv.pdf
html: cv.html index.html

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

index.html: cv.html
	echo "---" > $@
	echo " layout: default" >> $@
	echo " title: T.B. Hartman - CV" >> $@
	echo " css: ['/cv/cv.css']" >> $@
	echo "---" >> $@
	sed -n '/<body>/,/<\/body>/p' cv.html | sed -n '1!p' | sed -n '$$!p' >> $@

clean:
	latexmk -c cv

