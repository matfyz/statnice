@echo off
IF not EXIST out\ mkdir out

pdflatex -interaction=nonstopmode -output-directory=out "I1-Algoritmy_a_slozitost.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I1-Neproceduralni_programovani_a_umela_inteligence.tex"

pdflatex -interaction=nonstopmode -output-directory=out "I2-Databazove_systemy.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I2-Pocitacova_grafika.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I2-Softwarove_inzenyrstvi.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I2-Spolehlive_systemy.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I2-Systemove_architektury.tex"

pdflatex -interaction=nonstopmode -output-directory=out "I3-Matematicka_lingvistika.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I3-Matematicka_lingvistika-2009.tex"

pdflatex -interaction=nonstopmode -output-directory=out "I4-Diskretni_matematika_a_kombinatoricka_optimalizace.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I4-Matematicke_struktury_informatiky.tex"
pdflatex -interaction=nonstopmode -output-directory=out "I4-Optimalizace.tex"
