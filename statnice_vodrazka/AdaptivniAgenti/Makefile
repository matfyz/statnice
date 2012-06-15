FILE=adaptivniAgenti

${FILE}: ${FILE}.ps
	ps2pdf ${FILE}.ps

${FILE}.ps: ${FILE}.dvi
	dvips ${FILE}.dvi

${FILE}.dvi: ${FILE}.tex
	cslatex ${FILE}.tex

clean:
	rm ${FILE}.pdf ${FILE}.ps ${FILE}.dvi
