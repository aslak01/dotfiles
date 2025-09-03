#!/bin/zsh

function 8mbvid() {
    input=$1
    output=$2

    length=$(ffprobe -i "$input" -show_entries format=duration -v quiet -of csv="p=0")

    mins=$(awk -v var1=$length -v var2=60 'BEGIN { print  ( var1 / var2 ) }')

    bitrate=$(awk -v var1=1020 -v var2=$mins 'BEGIN { print ( var1 / var2 ) }')
    bitrateOver=$(bc <<<"$bitrate  * 0.94")
    bitrateVid=$(bc <<<"$bitrateOver - 64")
    bitrateAudio=64

    ffmpeg -i "$input" -an -c:v libx264 -b:v ${bitrateVid}k -preset fast -pass 1 -f null /dev/null

    ffmpeg -i "$input" -c:a aac -aac_coder twoloop -b:a ${bitrateAudio}k -c:v libx264 -b:v ${bitrateVid}k -preset fast -pass 2 "$output"
}

function gif2mp4() {
    # https://unix.stackexchange.com/a/294892
    input=$1
    output=$2
    ffmpeg -i "$input" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$output"
}
