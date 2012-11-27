$pdf_previewer = 'start evince %O %S';
$pdflatex = 'pdflatex -synctex=1 -file-line-error %O %S';
$pdf_mode = 1;
$recorder = 1;
#$bibtex_use = 0;
$bibtex = "bibtex %O %S; echo TBH boldface edits...; awk -f boldface.awk cv.bbl > cv.bbl.bak; mv cv.bbl.bak cv.bbl";
@default_files = ("cv.tex");
#$dependents_list = 1;

#add_cus_dep( 'bbl', 'aux', 0, 'tbhbibtex' );
#sub fig2eps {
#    system("cp $_[0].aux $_[0].bbl");
#}


