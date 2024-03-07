#!/bin/zsh

function janbanchanS() {
    REQ="$1"
    BASE_URL="$JANITR_STAGE_URL"
    AUTH="'Authorization: Basic' "$JANITR_STAGE_TOKEN""
    URL="$BASE_URL"ban?keys[]="$REQ"
    # echo "--location -g $URL --header "$AUTH""
    curl --location -g $URL --header "$AUTH"
}

function janbanurlS() {
    REQ="$1"
    BASE_URL="$JANITR_STAGE_URL"
    AUTH="'Authorization: Basic' "$JANITR_STAGE_TOKEN""
    URL="$BASE_URL"ban/$REQ
    # echo "--location -g $URL --header "$AUTH""
    curl --location -g $URL --header "$AUTH"
}

function janbanchanP() {
    REQ="$1"
    BASE_URL="$JANITR_URL"
    AUTH="'Authorization: Basic' "$JANITR_TOKEN""
    URL="$BASE_URL"ban?keys[]="$REQ"
    # echo "--location -g $URL --header "$AUTH""
    curl --location -g $URL --header "$AUTH"
}
