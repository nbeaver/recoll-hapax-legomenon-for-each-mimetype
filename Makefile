CMD:=apg -n 1 -M L
TOP_DIR:=out
BASE_FILENAME:=hapax_legomenon
SUFFIXES:=awk c markdown mdown md pl py rst sh tex txt
FILES:=$(addprefix $(TOP_DIR)/$(BASE_FILENAME).,$(SUFFIXES))
$(info $(FILES))

.PHONY: all
all : $(FILES) $(TOP_DIR)/Makefile

$(TOP_DIR)/Makefile :
	$(CMD) > $@

$(TOP_DIR)/$(BASE_FILENAME).%:
	$(CMD) > $@

.PHONY: index
index :
	find $(TOP_DIR)/ -print | recollindex -e -i

.PHONY: search
search :
	# Use command substitution instead of `cat`.
	find $(TOP_DIR)/ -name '.gitignore' -prune -o -type f -exec ./recoll-contents.sh '{}' \;
