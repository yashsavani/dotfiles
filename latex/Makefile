build:
	./convert.sh

check:
	@echo "The following items may contain weak word usage.--------------------"
	@sh ./weasels.sh s_*.md 1>&2
	@echo "The following items may contain passive language.-------------------"
	@sh ./passive_voice.sh s_*.md 1>&2
	@echo "The following items may contain unnecessary duplication.------------"
	@perl ./dups s_*.md 2>&2
	# @echo "Checking spelling.---------------------------------------------------"
	# @ispell s_*.md 
	@echo "Checking diction.---------------------------------------------------"
	@sh diction.sh s_*.md 1>&2

# style:
# 	@echo "Checking for nominalizations.---------------------------------------"
# 	@sh style.sh s_*.md 1>&2

test:
	#$(MAKE) check
	$(MAKE) build
	# ./focus &> /dev/null

open:
	open document.pdf
	# evince document.pdf &

clean:
	rm -f *.out *.pdf *.aux *.dvi *.log *.blg *.bbl *.tex-ee
