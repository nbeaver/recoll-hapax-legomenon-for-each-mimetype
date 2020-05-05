TEMPLATES:=templates
TOP_DIR:=out
TIMESTAMP=$(shell date +%s)

.PHONY: regenerate
regnenerate :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/
	find $(TOP_DIR)/ -print | recollindex -e -i
	./get-mimetypes.sh out/* > mimetypes.txt
	./search-for-files.sh out/hapax_list.txt | less

.PHONY: generate-files
generate-files :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: generate-files-debug
generate-files-debug :
	./generate_files.py --debug $(TEMPLATES)/ $(TOP_DIR)/


.PHONY: time-generate-files
time-generate-files :
	/usr/bin/time -o time_$(TIMESTAMP).log --verbose ./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: index
index :
	find $(TOP_DIR)/ -print | recollindex -e -i

.PHONY: search
search :
	./search-for-files.sh out/hapax_list.txt

.PHONY: search-quiet
search-quiet :
	-./search-for-files.sh out/hapax_list.txt | grep 'results' | grep -xv '2 results'

.PHONY: show-files
show-files :
	xapian-delve -1 -A Q"$$(realpath .)" ~/.recoll/xapiandb/

clean :
	rm -f -- $(TOP_DIR)/*
