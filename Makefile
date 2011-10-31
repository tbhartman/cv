# TBH Makefile

OUT_DIR=./_tex
CWD=$(PWD)

all: cv.pdf cv.html

cv.pdf: cv.tex
	#cp ~/Dropbox/VT/Research/JournalArticles/hartman.bib pw_report.bib
	pdflatex -interaction=batchmode -output-directory=$(OUT_DIR) cv 1>> /dev/null
	#cd $(OUT_DIR); export BIBINPUTS=$(CWD); bibtex -terse cv.aux; cd $(CWD)
	pdflatex -interaction=batchmode -output-directory=$(OUT_DIR) cv 1>> /dev/null
	#makeindex -q $(OUT_DIR)/cv
	#pdflatex -interaction=batchmode -output-directory=$(OUT_DIR) cv 1>> /dev/null
	cp $(OUT_DIR)/cv.pdf .
	# send to www
	cp cv.pdf ~/www/cv/hartman_cv.pdf

cv.html: cv.tex
	pandoc -f latex -t html cv.tex > cv.html
	# patch for ^nd
	sed -i 's/<span class="math">..{\\texttt{nd}}..\/span>/<sup>nd<\/sup>/g' cv.html
	# patch for "Last updated:"
	sed -i 's/<p>Last updated:<.p>/<!---->/' cv.html
	# patch for my missing name
	sed -i 's/<p>{ }<.p>/<!---->/' cv.html
	# send to www
	cp cv.html ~/www/cv/cv.html

clean:
	rm _tex/*
