PDFCROP = pdfcrop
RM=/bin/rm
TIKZDIR=src/tikz/

ifndef DEBUG
LATEXMK = latexmk -silent -f -g -pdf
PDFLATEX = mkdir -p build/;pdflatex -interaction=batchmode -output-directory=build/
MOVE = cp build/*.pdf ./
else
LATEXMK = latexmk -g -pdf
PDFLATEX = pdflatex mkdir -p build/;-output-directory=build/
MOVE = cp build/*.pdf ./
endif

TIKZFILES = $(wildcard src/tikz/*.tex)
TIKZPDF = $(patsubst %.tex,%.pdf,$(TIKZFILES))

default: tikz.fmt main.fmt $(TIKZPDF)
	$(LATEXMK) main.tex
	$(MOVE)

src/tikz/%.pdf: src/tikz/%.tex
	echo $<
	$(PDFLATEX) -fmt="build/tikz.fmt" -output-directory="src/tikz/" $<
	$(PDFCROP) $@ $@

main.fmt:
	$(PDFLATEX) -ini -jobname="main" "&pdflatex include/header.tex\dump"

tikz.fmt:
	$(PDFLATEX) -ini -jobname="tikz" "&pdflatex include/tikz.tex\dump"

clean : .PHONY
	$(RM) -rf build/
	@$(RM) -f -- *.{aux,bak,bbl,blg,dvi,fdb_latexmk,fmt,log,out,toc,tdo,fls}
	@$(RM) -f -- src/tikz/*.{aux,bak,bbl,blg,dvi,fdb_latexmk,mt,log,out,toc,tdo,fls}

depclean : clean
	$(RM) -f -- src/tikz/*.pdf

distclean : depclean
	$(RM) -f -- main.pdf

.PHONY:
