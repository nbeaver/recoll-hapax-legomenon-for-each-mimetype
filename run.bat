set TEMPLATES=templates
set TOP_DIR=out
set MANUAL_DIR=manually-generated
python generate_files.py %TEMPLATES%/ %TOP_DIR%/
touch %MANUAL_DIR%/*
python print_filepaths.py --real-paths %TOP_DIR% | recollindex -e -i
python print_filepaths.py %MANUAL_DIR%/ --real-paths | recollindex -e -i
bash get-file-mimetypes.sh %TOP_DIR%/* %MANUAL_DIR%/* > file-mimetypes.txt
bash get-mimetypes.sh %TOP_DIR%/* %MANUAL_DIR%/* | sort | uniq > mimetypes.txt
python search_for_unique_strings.py %TOP_DIR%/hapax_list.txt %MANUAL_DIR%/manual_mappings.txt > report.txt
pause
