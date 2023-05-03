#!/bin/zsh

function slugify {
    local input="$(echo -e "${1}" | iconv -f utf-8 -t ascii//TRANSLIT)"  # Convert non-ASCII characters to closest ASCII equivalent
    input="$(echo -e "${input}" | sed -E 's/^\s+|\s+$//g')"  # Trim excess whitespace at beginning and end
    input="$(echo -e "${input}" | tr '[:upper:]' '[:lower:]')"  # Convert to lowercase
    input="$(echo -e "${input}" | tr '[:space:]' '-')"  # Convert spaces to dashes
    input="$(echo -e "${input}" | sed 's/[^-[:alnum:]]//g')"  # Remove non-alphanumeric characters except dashes
    input="$(echo -e "${input}" | sed 's/-\{2,\}/-/g')"  # Remove multiple dashes in a row
    input="$(echo -e "${input}" | sed 's/^-//g; s/-$//g')"  # Remove leading/trailing dashes
    echo "${input}"
}
