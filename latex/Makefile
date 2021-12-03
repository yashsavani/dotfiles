build:
	${HOME}/.config/latex/convert.sh

check:
	@echo "The following items may contain weak word usage.--------------------"
	@sh ${HOME}/.config/latex/weasels.sh s_*.md 1>&2
	@echo "The following items may contain passive language.-------------------"
	@sh ${HOME}/.config/latex/passive_voice.sh s_*.md 1>&2
	${HOME}/.config/latex/passive_voice.sh s_*.md 1>&2
	@echo "The following items may contain unnecessary duplication.------------"
	@perl ${HOME}/.config/latex/dups s_*.md 2>&2
	# @echo "Checking spelling.---------------------------------------------------"
	# @ispell s_*.md 
	@echo "Checking diction.---------------------------------------------------"
	@sh ${HOME}/.config/latex/diction.sh s_*.md 1>&2

# style:
# 	@echo "Checking for nominalizations.---------------------------------------"
# 	@sh style.sh s_*.md 1>&2

test:
	#$(MAKE) check
	$(MAKE) build
	# ./focus &> /dev/null

open:
	# open document.pdf
	/Applications/Skim.app/Contents/SharedSupport/displayline document.pdf
	# evince document.pdf &

clean:
	rm -f *.out *.pdf *.aux *.dvi *.log *.blg *.bbl *.tex-ee *.fdb_latexmk *.fls *.synctex*
