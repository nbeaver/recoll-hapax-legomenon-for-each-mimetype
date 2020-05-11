TEMPLATES:=templates
TOP_DIR:=out
TIMESTAMP=$(shell date +%s)

.PHONY: regenerate
regnenerate :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/
	touch $(TOP_DIR)/manual_unique_string.*
	find $(TOP_DIR)/ -print | recollindex -e -i
	./get-file-mimetypes.sh out/* > file-mimetypes.txt
	./get-mimetypes.sh out/* | sort | uniq > mimetypes.txt
	./search-for-files.sh out/hapax_list.txt out/manual_mappings.tsv | less

.PHONY: generate-files
generate-files :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: generate-files-debug
generate-files-debug :
	./generate_files.py --debug $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: mimetypes.txt
mimetypes.txt :
	./get-mimetypes.sh out/* | sort | uniq > mimetypes.txt

.PHONY: file-mimetypes.txt
file-mimetypes.txt :
	./get-file-mimetypes.sh out/* > file-mimetypes.txt

.PHONY: time-generate-files
time-generate-files :
	/usr/bin/time -o time_$(TIMESTAMP).log --verbose ./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: index
index :
	find $(TOP_DIR)/ -print | recollindex -e -i

.PHONY: search
search :
	./search-for-files.sh out/hapax_list.txt out/manual_mappings.tsv

.PHONY: search-quiet
search-quiet :
	-./search-for-files.sh out/hapax_list.txt out/manual_mappings.tsv | grep 'results' | grep -xv '2 results'

.PHONY: show-files
show-files :
	xapian-delve -1 -A Q"$$(realpath .)" ~/.recoll/xapiandb/

clean :
	rm -f -- $(TOP_DIR)/*
