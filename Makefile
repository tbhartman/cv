# TBH Makefile

all: pdf html

.PHONY: pdf html 

pdf: | cv.pdf teaching_philosophy.pdf
html:: cv.html

%.pdf::
	latexmk

clean_tex= \
	rm -f `ls $(1)* | grep -ve "$(1)\.\(pdf\|bst\|bib\|tex\|synctex.gz\)$$"`

clean:
	$(call clean_tex,cv)
	$(call clean_tex,teaching_philosophy)

cv.html: cv.tex
	pandoc -f latex -t html cv.tex > cv.html
	# patch for ^nd
	sed -i 's/<span class="math">..{\\texttt{nd}}..\/span>/<sup>nd<\/sup>/g' cv.html
	# patch for "Last updated:"
	sed -i 's/<p>Last updated:<.p>/<!---->/' cv.html
	# patch for my missing name
	sed -i 's/<p>{ }<.p>/<!---->/' cv.html
