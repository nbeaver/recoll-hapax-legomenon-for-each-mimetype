CMD:=apg -n 1 -M L -m 30
# -n 1: generate just one
# -M l: lowercase letters only
# -m 30: minimum of 30 characters
TOP_DIR:=out
BASE_FILENAME:=hapax_legomenon
SUFFIXES:=awk c desktop markdown mdown md pl py rst sh tex txt
FILES:=$(addprefix $(TOP_DIR)/$(BASE_FILENAME).,$(SUFFIXES))

.PHONY: all
all : $(FILES) $(TOP_DIR)/Makefile

$(TOP_DIR)/Makefile :
	$(CMD) > $@

$(TOP_DIR)/$(BASE_FILENAME).desktop :
	./generate-desktop.sh $$($(CMD)) > $@

$(TOP_DIR)/$(BASE_FILENAME).%:
	$(CMD) > $@

.PHONY: index
index :
	find $(TOP_DIR)/ -print | recollindex -e -i

.PHONY: search
search :
	find $(TOP_DIR)/ -name '.gitignore' -prune -o -type f -print -exec ./recoll-contents.sh '{}' \;

.PHONY: search-quiet
search-quiet :
	-find $(TOP_DIR)/ -name '.gitignore' -prune -o -type f -exec ./recoll-contents.sh '{}' \; | grep 'results' | grep -xv '1 results'

.PHONY: show-files
show-files :
	xapian-delve -1 -A Q"$$(realpath .)" ~/.recoll/xapiandb/

clean :
	rm -f -- $(FILES) $(TOP_DIR)/Makefile
