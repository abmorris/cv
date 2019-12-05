MAIN = cv
SILENT = &>/dev/null
BATCH = -interaction=batchmode
LATEX = pdflatex -shell-escape $(BATCH) -output-directory=$(1) $(2) $(SILENT)
BIBTEX = bibtex -terse $(1) $(SILENT)

#BUILDCOMMAND = $(call LATEX,$(2),$(1)) && $(call LATEX,$(2),$(1)) && $(call LATEX,$(2),$(1))
BUILDCOMMAND = rubber -d $(1)


TEXSOURCES = $(shell find . -type f -name "*.tex")
BIBSOURCES = $(shell find . -type f -name "*.bib")
BSTSOURCES = $(shell find . -type f -name "*.bst")
STYSOURCES = $(shell find . -type f -name "*.sty")
ALLSOURCES = $(TEXSOURCES) $(BIBSOURCES) $(BSTSOURCES) $(STYSOURCES)

BUILDFILES = *.aux *.log *.bbl *.blg *.dvi *.tmp *.out *.blg *.bbl *.toc *.lof *.lot

all : $(MAIN).pdf Makefile
	@rm -f $(BUILDFILES)

$(MAIN).pdf : $(ALLSOURCES)
	@echo "Building $@"
	@$(call BUILDCOMMAND,$(MAIN),.)

.PHONY : debug
debug: SILENT =
debug: BATCH =
debug: all


.PHONY : clean
clean: tidy rmout

.PHONY : tidy
tidy:
	@rm -f $(BUILDFILES)

.PHONY: rmout
rmout:
	@rm -f $(MAIN).pdf
