#!/usr/local/bin/bash

DEVNULL=">/dev/null"

if [ x$1 = x"nodevnull" ]; then
	DEVNULL=""
fi

if [ ! -d tmp ]; then
	mkdir tmp
fi

if [ ! -d out ]; then
	mkdir out
fi

function RebuildIndex {
	idx_name=$1
	# make $idx_name_#.tex files, if required
	
	#perform quick test (files' existence and date)
	allok=1
	for x in `seq 1 \`grep "\section" $idx_name.tex | wc -l\``; do
		idx_fn="${idx_name}_$x.tex"
		if [ -f $idx_fn ]; then
			if [ `stat "$idx_name.tex" -c '%Y'` -gt `stat $idx_fn -c '%Y'` ]; then
				allok=0
				break
			fi
		else
			allok=0
		fi
	done

	if [ $allok = 1 ]; then
		return 0
	fi

	#full test+output (regenerate missing/outdated files)
	idx_head=1
	idx_id=0
	idx_fn=""
	idx_title=""
	while read -r line; do
		if [ `echo $line | grep "\section" | wc -l` -ge 1 ]; then
			idx_head=0
			if [ $idx_id -gt 0 ]; then
				echo "\\end{document}" >>$idx_fn
			fi
			idx_id=$(($idx_id+1)) #TODO: this might be bash-only
			idx_fn="${idx_name}_$idx_id.tex"
			if [ -f $idx_fn ]; then
				if [ `stat "$idx_name.tex" -c '%Y'` -lt `stat $idx_fn -c '%Y'` ]; then
					idx_fn="/dev/null"
				fi
			fi
			echo "\\clearpage \\input{format.tex} \\clearpage" >$idx_fn
			title=`echo $line | sed "s%.*{\(.*\)}.*%\1%"`
			echo "\\title{\\LARGE Učební texty k státní bakalářské zkoušce \\\\ $idx_title \\\\ $title}" >>$idx_fn
			echo "\\begin{document}" >>$idx_fn
			echo "\\maketitle" >>$idx_fn
			echo "\\newpage" >>$idx_fn
			echo "\\setcounter{section}{$(($idx_id-1))}">>$idx_fn
			echo "\\section{$title}">>$idx_fn
		elif [ $idx_head = 0 ]; then
			echo ${line} >>$idx_fn
		elif [ `echo $line | grep "^.title{" | wc -l` -ge 1 ]; then
			idx_title=$(echo $line|sed "s%.*\\\\ \(.*\)\}%\1%")
		fi
	done <$idx_name.tex
	#\enddocument is already in the $idx_name.tex :-)
}

RebuildIndex Programovani
RebuildIndex Obecna_informatika
RebuildIndex Sprava_pocitacovych_systemu

# pdfcslatex-ize tex files
for f in `ls *.tex | grep '^[A-Z].*'`; do
	tgt=`echo out/$f | sed "s%.tex$%.pdf%"`
	tmp=`echo $f | sed "s%.tex$%.pdf%"`
	
	need_to_make=0

	if [ ! -f $tgt ]; then
		need_to_make=1
	else
		tgt_date=`stat $tgt -c '%Y'`
		if [ `stat $f -c '%Y'` -gt $tgt_date ]; then
			need_to_make=1
		fi
		
		#check included (inputted) files
		for inf in `grep '\input' $f | sed "s%.*{\(.*\)}.*%\1%"`; do
			if [ `stat $inf -c '%Y'` -gt $tgt_date ]; then
				need_to_make=1
			fi
		done
	fi

	if [ $need_to_make -ge 1 ]; then
		echo -n "Compiling" $f "."
		eval "pdfcslatex -interaction=nonstopmode $f $DEVNULL"
		echo -n "."
		eval "pdfcslatex -interaction=nonstopmode $f $DEVNULL"
		echo "."

		if [ `echo $f | grep "^[A-Za-z_]*\." | wc -l` = 0 ]; then
			awk 'BEGIN{block=0}       /\(\.\/[im]/ {block=1}         /^Here is how much/ {block=2}         /.*/ { if (block==1) print $0 } ' `echo "$f" | sed "s%.tex%.log%"`
			echo "_______________________________________________________________________"; echo;
		fi
	fi

	if [ -f $tmp ]; then
		mv -f $tmp $tgt
		fp=`echo "$f" | sed "s%.tex%%"`
		mv -f $fp.aux tmp
		mv -f $fp.log tmp
		mv -f $fp.out tmp
		if [ -f $fp.toc ]; then
			mv -f $fp.toc tmp
		fi
	fi
done
