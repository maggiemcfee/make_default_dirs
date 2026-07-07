#!/bin/bash
# set -e

### Check for two inputs
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 SHAREPATH LOGFILE"
    echo "SHAREPATH should be a full path. ex. - /n/Lab_storage/jharvard_lab"
    echo "LOGFILE should be the full path to your log file. ex. - /temp/mylogfile.log"
    exit 1
fi

### Assign inputs to variables
file_path="$1"
log_file_path="$2"

### Check if log file exists and is writeable
if [ -e "$log_file_path" ] && [ ! -w "$log_file_path" ]; then
    echo "Log file not writeable. Exiting."
    exit 1
fi

### Get group and owner
lab_group=$(stat -c "%G" "$file_path")
lab_owner=$(stat -c "%U" "$file_path")

### Write file path and permissions to log
permissions=$(stat -c "%a" "$file_path")
echo -n "File path: $file_path - " >> "$log_file_path"
echo -n "Owner: $lab_owner - Group: $lab_group - " >> "$log_file_path"
echo "Permissions: $permissions" >> "$log_file_path"

### Check for and create Lab directory if not found
lab_dir="$file_path/Lab"
if [ -d "$lab_dir" ]; then
    echo "Lab exists" >> "$log_file_path"
else
    install -d -m 2770 -g "$lab_group" "$lab_dir"
    echo "Lab created" >> "$log_file_path"
fi

# Check and create Everyone directory
everyone_dir="$file_path/Everyone"
if [ -d "$everyone_dir" ]; then
    echo "Everyone exists" >> "$log_file_path"
else
    install -d -m 0775 -g "$lab_group" "$everyone_dir"
    echo "Everyone created" >> "$log_file_path"
fi
