@echo off
IF not EXIST out\ mkdir out

pdflatex -interaction=nonstopmode -output-directory=out "Matematika.tex"
pdflatex -interaction=nonstopmode -output-directory=out "Obecna_informatika.tex"
pdflatex -interaction=nonstopmode -output-directory=out "Programovani.tex"
pdflatex -interaction=nonstopmode -output-directory=out "Sprava_pocitacovych_systemu.tex"

rem dvipdfm -o "out/Programovani_1.pdf" "out/Programovani_1.dvi"
