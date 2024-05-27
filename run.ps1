$template = "templates"
$top_dir = "out"
$manual_dir = "manually-generated"
python generate_files.py $templates" $top_dir"
touch "$manual_dir"/*
Get-ChildItem "C:\Users\gerhardl\Documents\My Received Files" -Filter *.log | 
Foreach-Object {
    $content = Get-Content $_.FullName

    #filter and save content to the original file
    $content | Where-Object {$_ -match 'step[49]'} | Set-Content $_.FullName

    #filter and save content to a new file 
    $content | Where-Object {$_ -match 'step[49]'} | Set-Content ($_.BaseName + '_out.log')
}
python print_filepaths.py --real-paths %TOP_DIR% | recollindex -e -i
python print_filepaths.py %MANUAL_DIR%/ --real-paths | recollindex -e -i
bash get-file-mimetypes.sh %TOP_DIR%/* %MANUAL_DIR%/* > file-mimetypes.txt
bash get-mimetypes.sh %TOP_DIR%/* %MANUAL_DIR%/* | sort | uniq > mimetypes.txt
python search_for_unique_strings.py %TOP_DIR%/hapax_list.txt %MANUAL_DIR%/manual_mappings.txt > report.txt
