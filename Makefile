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

%.full.html: %.xsl %.xml
	xsltproc $^ > $@

CV_VERSION_HTML:: CV_VERSION_FILE
	echo "<div id='version'>" > $@
	sed -n '1s!\(.*\)!<span class="hash">\1</span>!gp' $^ >> $@
	sed -n '2s!\(.*\)!<span class="date">\1</span>!gp' $^ >> $@
	echo "</div>" >> $@

cv.html: cv.full.html CV_VERSION_HTML
	sed -n '/<body>/,/<\/body>/p' $^ | sed -n '1!p' | sed -n '$$!p' > $@
	cat CV_VERSION_HTML >> $@

index.html: cv.html
	echo "---" > $@
	echo " layout: default" >> $@
	echo " title: T.B. Hartman - CV" >> $@
	echo " css: ['/cv/cv.css']" >> $@
	echo "---" >> $@
	cat $^ >> $@

clean:
	rm -f cv-blx.bib
	rm -f cv.aux
	rm -f cv.fdb_latexmk
	rm -f cv.fls
	rm -f cv.log
	rm -f cv.out
	rm -f cv.tex
	rm -f cv.texml
	rm -f CV_VERSION_FILE
	rm -f CV_VERSION_HTML
	rm -f cv.full.html
	rm -f cv.pdf

CV_VERSION_FILE::
	git log -n 1 --pretty="%H" > $@
	git log -n 1 --pretty="%cd" --date=rfc | \
		gawk '{printf "%02d %s %d\n", $$2, $$3, $$4}' | \
		sed 's/Jan/January/' | \
		sed 's/Feb/February/' | \
		sed 's/Mar/March/' | \
		sed 's/Apr/April/' | \
		sed 's/May/May/' | \
		sed 's/Jun/June/' | \
		sed 's/Jul/July/' | \
		sed 's/Aug/August/' | \
		sed 's/Sep/September/' | \
		sed 's/Oct/October/' | \
		sed 's/Nov/November/' | \
		sed 's/Dec/December/' >> $@

