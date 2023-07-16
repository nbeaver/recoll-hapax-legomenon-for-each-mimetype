TEMPLATES:=templates
TOP_DIR:=out
MANUAL_DIR:=manually-generated
TIMESTAMP:=$(shell date +%F_%s)

.PHONY: regenerate
regenerate :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/
	touch $(MANUAL_DIR)/*
	./print_filepaths.py $(TOP_DIR)/ | recollindex -e -i
	./print_filepaths.py $(MANUAL_DIR)/ | recollindex -e -i
	./get-file-mimetypes.sh $(TOP_DIR)/* $(MANUAL_DIR)/* > file-mimetypes.txt
	./get-mimetypes.sh $(TOP_DIR)/* $(MANUAL_DIR)/* | sort | uniq > mimetypes.txt
	./search_for_unique_strings.py $(TOP_DIR)/hapax_list.txt $(MANUAL_DIR)/manual_mappings.txt 2>&1 | less

# recollindex -i will index individual files into the database
# recollindex -e will erase data for individual files from the database.
# Options -i and -e can be combined. This will first perform the purge, then the indexing.

.PHONY: generate-files
generate-files :
	./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: generate-files-debug
generate-files-debug :
	./generate_files.py --debug $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: time-generate-files
time-generate-files :
	/usr/bin/time -o time_$(TIMESTAMP).log --verbose ./generate_files.py $(TEMPLATES)/ $(TOP_DIR)/

.PHONY: mimetypes.txt
mimetypes.txt :
	./get-mimetypes.sh $(TOP_DIR)/* $(MANUAL_DIR)/* | sort | uniq > mimetypes.txt

.PHONY: file-mimetypes.txt
file-mimetypes.txt :
	./get-file-mimetypes.sh $(TOP_DIR)/* $(MANUAL_DIR)/* > file-mimetypes.txt

.PHONY: index
index :
	./print_filepaths.py $(TOP_DIR)/ | recollindex -e -i

.PHONY: search
search :
	./search_for_unique_strings.py $(TOP_DIR)/hapax_list.txt $(MANUAL_DIR)/manual_mappings.txt

.PHONY: search-quiet
search-quiet :
	-./search_for_unique_strings.py $(TOP_DIR)/hapax_list.txt $(MANUAL_DIR)/manual_mappings.txt | grep 'results' | grep -xv '2 results'

.PHONY: show-files
show-files :
	xapian-delve -1 -A Q"$$(realpath .)" ~/.recoll/xapiandb/

clean :
	rm -f -- $(TOP_DIR)/*
