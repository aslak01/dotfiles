function flf() {
    local folder_path="$1"
    local num_files="${2:-10}"

    find "$(realpath "$folder_path")" -type f -exec du -h {} + | sort -rh | head -n "$num_files"
}
