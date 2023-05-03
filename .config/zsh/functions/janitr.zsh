#!/bin/zsh

function janitrStageBanChannel() {
    REQ="$1"

    URL="$JANITR_STAGE_URL"
    AUTH="$JANITR_STAGE_TOKEN"

    curl --location -g "$URL"'/ban?keys[]='"$REQ" \
        --header 'Authorization: Basic ' "$TOKEN"
}

function janitrStageBanUrl() {
    REQ="$1"
    URL="$JANITR_STAGE_URL"
    AUTH="$JANITR_STAGE_TOKEN"

    curl --location -g "$URL"'/ban/'"$REQ" \
        --header 'Authorization: Basic ' "$TOKEN"
}
