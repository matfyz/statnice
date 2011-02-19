@echo off
IF not EXIST out\ mkdir out

pdflatex -interaction=nonstopmode -output-directory=out "i1-algoritmy-a-slozitost.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i1-neproceduralni-programovani-a-umela-inteligence.tex"

pdflatex -interaction=nonstopmode -output-directory=out "i2-databazove-systemy.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i2-pocitacova-grafika.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i2-softwarove-inzenyrstvi.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i2-spolehlive-systemy.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i2-systemove-architektury.tex"

pdflatex -interaction=nonstopmode -output-directory=out "i3-matematicka-lingvistika-2010.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i3-matematicka-lingvistika.tex"

pdflatex -interaction=nonstopmode -output-directory=out "i4-diskretni-matematiika-a-kombinatoricka-optimalizace.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i4-matematicke-struktury-informatiky.tex"
pdflatex -interaction=nonstopmode -output-directory=out "i4-optimalizace.tex"

rem dvipdfm -o "out/Programovani_1.pdf" "out/Programovani_1.dvi"
