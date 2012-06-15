vycislitelnost: vycislitelnost.ps
	ps2pdf vycislitelnost.ps

vycislitelnost.ps: vycislitelnost.dvi
	dvips vycislitelnost.dvi

vycislitelnost.dvi: vycislitelnost.tex
	cslatex vycislitelnost.tex

clean:
	rm vycislitelnost.pdf vycislitelnost.ps vycislitelnost.dvi
