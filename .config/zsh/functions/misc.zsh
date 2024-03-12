function flf() {
    local folder_path="$1"
    local num_files="${2:-10}"

    # Find files, get their sizes, sort, and display the top files
    find "$folder_path" -type f -exec du -h {} + | sort -rh | head -n "$num_files" | while read -r line; do
        # Extract size and path
        size=$(echo "$line" | awk '{print $1}')
        file=$(echo "$line" | cut -f2-)
        # Extract filename from the full path using basename
        # Colorize the size and print with a tab
        echo -e "\e[34m$size\e[0m\t$file"
    done
}
