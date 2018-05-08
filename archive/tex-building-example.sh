#!/bin/sh

if [ "$1" == "-f" ] ; then
	strictness=0
	shift 1
else
	strictness=1
fi

if ! grep '^## AUTOGENERATED' Makefile >/dev/null; then
    if [ $strictness != 0 ]; then
	cat 1>&2 <<EOF
Refusing to run: Makefile not generated by mkmakefile.
Run with -f to override.
EOF
	exit 1
    fi
fi

if [[ -n "$(git ls-files -o)" && $strictness != 0 ]]; then
    echo 'ERROR: There are untracked files, or you are not using git-svn.'
    echo 'Clean up manually. Try "git clean -xfd" (dangerous!).'
    echo 'Aborting.'
    exit 1
fi

basetex=$(for f in *.tex; do if grep -q '^\\documentclass' $f; then echo $f; fi; done | sort -u)
figdir=$(find . -name "*.fig" | while read f; do dirname $f; done | sort -u | perl -ne 'chomp; s{^\./}{}; print "$_ "')
pstdir=$(find . -name "*.pst" | while read f; do dirname $f; done | sort -u | head -1)
mpostdir=$(find . -name "*.mp" | while read f; do dirname $f; done | sort -u | head -1)
epsimgs=$(find . -name "*.eps" | sort | perl -ne 'chomp; s{^\./}{}; print "$_ "')
pdfepsconv=$(for f in $epsimgs; do p=$(dirname $f)/$(basename $f .eps).pdf; if [ ! -f $p ]; then echo $p; fi; done | perl -ne 'chomp; s{^\./}{}; print "$_ "')
pdfimgs=$(find . -name "*.pdf" | sort | perl -ne 'chomp; s{^\./}{}; print "$_ "')
epspdfconv=$(for f in $pdfimgs; do p=$(dirname $f)/$(basename $f .pdf).eps; if [ ! -f $p ]; then echo $p; fi; done | perl -ne 'chomp; s{^\./}{}; print "$_ "')
texglob=$(find . -name "*.tex" | sort | perl -ne 'chomp; s{^\./}{}; print "$_ "')

indexstyle=$(echo *.ist)
if [ -f "$indexstyle" ]; then
    indexstyle="-s $indexstyle"
else
    indexstyle=
fi

qlatex='$(Q)$(Q_LATEX)'
qother='$(Q)$(Q_OTHER)'

autorevision=
if grep -q '^[^%]*\input{revision}' $texglob; then
    autorevision=autorevision
fi

cat >Makefile.new <<\EOF
## AUTOGENERATED by mkmakefile

# say 'make V=1' to see the full build output
ifndef V
Q = @
Q_LATEX = sh -c 'echo -e "   " `echo $$(basename "$$0") | tr a-z A-Z`"\t$${!\#/..\/..\//}"; ! "$$0" "$$@" | grep -A5 -E "^[^ ]+:[0-9]+:"'
Q_OTHER = sh -c 'echo -e "   " `echo $$(basename "$$0") | tr a-z A-Z`"\t$${!\#/..\/..\//}"; "$$0" "$$@" >/dev/null'
endif

LATEX = latex
PDFLATEX = pdflatex
BIBTEX = bibtex
DVIPS = dvips
DVIPDF = dvipdf
PDFTOEPS = pdftops -eps
PDFTOPS = pdf2ps
EPSTOPDF = epstopdf
FIGTODEV = fig2dev
MPOST = mpost

EOF
cat >>Makefile.new <<EOF
.PHONY: all clean $autorevision

EOF

echo "all: $autorevision" $(for f in $basetex; do echo $(basename $f .tex); done) >> Makefile.new

if [ -n "$figdir" ]; then
    echo >>Makefile.new
    echo "figures=\$(patsubst %.fig,%.tex,"$(for d in $figdir; do echo -n '$(wildcard '$d/'*.fig) '; done)")" >>Makefile.new
    cat >>Makefile.new <<EOF

epsfigures=\$(patsubst %.tex,%.eps,\$(figures))
pdffigures=\$(patsubst %.tex,%.pdf,\$(figures))
EOF
fi

if [ -n "$epsimgs" ]; then
    cat >>Makefile.new <<EOF

epsimages=$epsimgs
pdfepsimages=\$(patsubst %.eps,%.pdf,\$(epsimages))
EOF
fi

if [ -n "$pdfimgs" ]; then
    cat >>Makefile.new <<EOF

pdfimages=$pdfimgs
epspdfimages=\$(patsubst %.pdf,%.eps,\$(pdfimages))
EOF
fi

if [ -n "$mpostdir" ]; then
    cat >>Makefile.new <<EOF
plots=\$(patsubst %.mp,%.1,\$(wildcard $mpostdir/*.mp))
EOF
fi

if [ -n "$pstdir" ]; then
    echo 'plots=$(wildcard '$pstdir'/*.pst)' >>Makefile.new
fi

cat >>Makefile.new <<EOF

texfiles = ${texglob}${autorevision:+revision.tex}
EOF

if grep '^[^%]*\usepackage{tikz}' $texglob >/dev/null; then
    # tikz wants only a pdf build, so generate the ps from that
    for tex in $basetex; do
	base=$(basename $tex .tex)
	pdf=$base.pdf
	bibtex=""
	if grep '^[^%]*\\bibliography' $tex >/dev/null; then
	    bibtex="	$qother \$(BIBTEX) $base
"
	fi
	makeindex=""
	if grep '^[^%]*\\printindex' $tex >/dev/null; then
	    germanquote=
	    if [ -n "$indexstyle" ] && grep -qE '^[^%]*\\usepackage *\[ *n?german *\] *\{ *babel *\}' $tex; then
		germanquote=-g
	    fi
	    makeindex="	\$(Q) touch $base.idx
	$qother makeindex -q $germanquote $indexstyle $base
"
	fi
	cat >>Makefile.new <<EOF

.PHONY: $base
$base: $pdf $base.ps

$pdf: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(pdffigures)} ${mpostdir:+\$(plots)} ${epsimgs:+\$(pdfepsimages)} ${pdfimgs:+\$(pdfimages)} ${makeindex:+$base.ind} ${bibtex:+$base.bbl}
	\$(Q) rm -rf build/pdf/; mkdir -p build/pdf/
	\$(Q) cd build/pdf/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(PDFLATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) cd build/pdf/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(PDFLATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) ln -f build/pdf/$base.pdf $base.pdf

$base.ps: $pdf
	$qother \$(PDFTOPS) \$< \$@

$base.aux: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(epsfigures)} ${mpostdir:+\$(plots)}
	\$(Q) \$(Q_LATEX) \$(PDFLATEX) -interaction=nonstopmode -file-line-error $tex
EOF

	if [ -n "$makeindex" ]; then
	    cat >>Makefile.new <<EOF

$base.ind: $base.aux
$makeindex
EOF
	fi

	if [ -n "$bibtex" ]; then
	    cat >>Makefile.new <<EOF

$base.bbl: $base.aux
$bibtex
EOF
	fi
    done
elif [ -z "$pstdir" -a -z "$mpostdir" ]; then
    # not using metapost or pstricks, so run pdflatex
    for tex in $basetex; do
	base=$(basename $tex .tex)
	pdf=$base.pdf
	dvi=$base.dvi
	bibtex=""
	if grep '^[^%]*\\bibliography' $tex >/dev/null; then
	    bibtex="	$qother \$(BIBTEX) $base
"
	fi
	makeindex=""
	if grep '^[^%]*\\printindex' $tex >/dev/null; then
	    germanquote=
	    if [ -n "$indexstyle" ] && grep -qE '^[^%]*\\usepackage *\[ *n?german *\] *\{ *babel *\}' $tex; then
		germanquote=-g
	    fi
	    makeindex="	\$(Q) touch $base.idx
	$qother makeindex -q $germanquote $indexstyle $base
"
	fi
	cat >>Makefile.new <<EOF

.PHONY: $base
$base: $pdf $base.ps

$pdf: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(pdffigures)} ${mpostdir:+\$(plots)} ${epsimgs:+\$(pdfepsimages)} ${pdfimgs:+\$(pdfimages)} ${makeindex:+$base.ind} ${bibtex:+$base.bbl}
	\$(Q) rm -rf build/pdf/; mkdir -p build/pdf/
	\$(Q) cd build/pdf/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(PDFLATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) cd build/pdf/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(PDFLATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) ln -f build/pdf/$base.pdf $base.pdf

$dvi: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(epsfigures)} ${mpostdir:+\$(plots)} ${epsimgs:+\$(epsimages)} ${pdfimgs:+\$(epspdfimages)} ${makeindex:+$base.ind} ${bibtex:+$base.bbl}
	\$(Q) rm -rf build/dvi/; mkdir -p build/dvi/
	\$(Q) cd build/dvi/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) cd build/dvi/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) ln -f build/dvi/$base.dvi $base.dvi

$base.ps: $dvi
	$qother \$(DVIPS) -q $base

$base.aux: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(epsfigures)} ${mpostdir:+\$(plots)}
	\$(Q) \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error $tex
EOF

	if [ -n "$makeindex" ]; then
	    cat >>Makefile.new <<EOF

$base.ind: $base.aux
$makeindex
EOF
	fi

	if [ -n "$bibtex" ]; then
	    cat >>Makefile.new <<EOF

$base.bbl: $base.aux
$bibtex
EOF
	fi
    done
else
    # using metapost or pstricks; resort to dvipdf
    for tex in $basetex; do
	base=$(basename $tex .tex)
	pdf=$base.pdf
	dvi=$base.dvi
	bibtex=""
	if grep '^[^%]*\\bibliography' $tex >/dev/null; then
	    bibtex="	$qother \$(BIBTEX) $base
"
	fi
	makeindex=""
	if grep '^[^%]*\\printindex' $tex >/dev/null; then
	    makeindex="	\$(Q) touch $base.idx
	$qother makeindex -q $indexstyle $base
"
	fi
	cat >>Makefile.new <<EOF

.PHONY: $base
$base: $pdf $base.ps

$dvi: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(epsfigures)} ${mpostdir:+\$(plots)} ${epsimgs:+\$(epsimages)} ${pdfimgs:+\$(epspdfimages)} ${makeindex:+$base.ind} ${bibtex:+$base.bbl}
	\$(Q) rm -rf build/dvi/; mkdir -p build/dvi/
	\$(Q) cd build/dvi/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) cd build/dvi/ && TEXINPUTS="../../:\$\$TEXINPUTS" \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error ../../$tex
	\$(Q) ln -f build/dvi/$base.dvi $base.dvi

$base.ps: $dvi
	$qother \$(DVIPS) -q $base

$pdf: $dvi
	$qother \$(DVIPDF) $base

$base.aux: \$(texfiles) ${figdir:+\$(figures)} ${figdir:+\$(epsfigures)} ${mpostdir:+\$(plots)}
	\$(Q) \$(Q_LATEX) \$(LATEX) -interaction=nonstopmode -file-line-error $tex
EOF

	if [ -n "$makeindex" ]; then
	    cat >>Makefile.new <<EOF

$base.ind: $base.aux
$makeindex
EOF
	fi

	if [ -n "$bibtex" ]; then
	    cat >>Makefile.new <<EOF

$base.bbl: $base.aux
$bibtex
EOF
	fi
    done
fi


if [ -n "$figdir" ]; then
    cat >>Makefile.new <<EOF

.PHONY: figures texfigures epsfigures pdffigures
figures: texfigures epsfigures pdffigures
texfigures: \$(figures)
epsfigures: \$(epsfigures)
pdffigures: \$(pdffigures)
\$(figures): %.tex: %.fig
	$qother \$(FIGTODEV) -L pstex_t -p \$(patsubst %.tex,%,\$@) \$< \$@
\$(epsfigures): %.eps: %.fig
	$qother \$(FIGTODEV) -L pstex \$< \$(patsubst %.tex,%.eps,\$@)
\$(pdffigures): %.pdf: %.fig
	$qother \$(FIGTODEV) -L pdftex -p dummy \$< \$(patsubst %.tex,%.pdf,\$@)
EOF
fi

if [ -n "$mpostdir" ]; then
    cat >>Makefile.new <<EOF

.PHONY: plots
plots: \$(plots)
\$(plots): %.1: %.mp
	\$(Q)cd $mpostdir && \$(Q_LATEX) \$(MPOST) -file-line-error \`basename \$<\`
EOF
fi

if [ -n "$pdfepsconv" ]; then
    cat >>Makefile.new <<EOF

pdfepsconv = $pdfepsconv
\$(pdfepsconv): %.pdf: %.eps
	$qother \$(EPSTOPDF) \$<
EOF
fi

if [ -n "$epspdfconv" ]; then
    cat >>Makefile.new <<EOF

epspdfconv = $epspdfconv
\$(epspdfconv): %.eps: %.pdf
	$qother \$(PDFTOEPS) -f 1 -l 1 \$<
EOF
fi

if [ -n "$autorevision" ]; then
    cat >>Makefile.new <<\EOF

revision.tex: autorevision
autorevision:
	@ if [ -n "$(Q)" ]; then echo -e "    REVISION\trevision.tex"; fi
	$(Q) (echo -e '\makeatletter\n\usepackage{svn}'; ( $(CDSVNWC) (svn info || git svn info || echo -e 'Last Changed Rev\nLast Changed Author\nLast Changed Date') 2>/dev/null | perl -ne 'print if s/^Last Changed (\S+(?::( ).*)?)$$/\\SVN \$$$$1$$2\$$/'; echo '\makeatother')) > revision.tex.new
	$(Q) if cmp -s revision.tex revision.tex.new; then rm -f revision.tex.new; else mv -f revision.tex.new revision.tex; fi
EOF
fi

cat >>Makefile.new <<EOF
clean:
	rm -rf build/
	rm -f *.aux
EOF
for tex in $basetex; do
    base=$(basename $tex .tex)
    echo "	"rm -f $base.dvi $base.idx $base.ind $base.ilg $base.out $base.toc $base.pdf $base.log >>Makefile.new
done

if [ -n "$figdir" ]; then
    echo "	for f in \$\$(find . -name '*.fig'); do rm -f \$\$(dirname \$\$f)/\$\$(basename \$\$f .fig).{eps,pdf,tex}; done" >>Makefile.new
fi

mv -f Makefile.new Makefile
