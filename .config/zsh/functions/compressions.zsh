#!/bin/zsh


function 8mbvid() {
    input=$1
    output=$2

    length=$(ffprobe -i "$input" -show_entries format=duration -v quiet -of csv="p=0")

    mins=$(awk -v var1=$length -v var2=60 'BEGIN { print  ( var1 / var2 ) }')

    bitrate=$(awk -v var1=1020 -v var2=$mins 'BEGIN { print ( var1 / var2 ) }')
    bitrateOver=$(bc<<<"$bitrate  * 0.94")
    bitrateVid=$(bc<<<"$bitrateOver - 64")
    bitrateAudio=64

    ffmpeg -i "$input" -an -c:v libx264 -b:v ${bitrateVid}k -preset fast -pass 1 -f null /dev/null

    ffmpeg -i "$input" -c:a aac -aac_coder twoloop -b:a ${bitrateAudio}k -c:v libx264 -b:v ${bitrateVid}k -preset fast -pass 2 "$output"
}

# function vidToTarMb() {
#     input_file="$1"
#     target_size_mb="$2"
#     output_file="${input_file%.*}_compressed.mp4"
#
#     if [ -z "$input_file" ] || [ -z "$target_size_mb" ]; then
#         echo "Usage: $0 <input_video_file> <target_size_in_MB>"
#         exit 1
#     fi
#
#     # Get the width and height from the video using ffprobe
#     dimensions=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input_file")
#
#     if [ $? -ne 0 ]; then
#         echo "Error: ffprobe command failed."
#         exit 1
#     fi
#
#     # Assign dimensions directly to width and height variables
#     IFS='x' read -r width height <<< "$dimensions"
#
#     width=$((width))
#     height=$((height))
#
#     echo "Video Dimensions: ${width}x${height}"

# Calculate the target bitrate based on the input target size
# denominator=$((width * height + 1))
#
#
# if [ "$denominator" -le 0 ]; then
#     echo "Error: Invalid denominator for bitrate calculation."
#     exit 1
# fi
# echo "Denominator: $denominator"

# target_bitrate=$((target_size_mb * 8192 / denominator))
#
#
# if [ "$target_bitrate" -le 0 ]; then
#     echo "Error: Failed to calculate valid target bitrate."
#     exit 1
# fi
#
#
# echo "Target Bitrate: ${target_bitrate}k"

# ffmpeg -y -i "$input_file" -c:v libx264 -b:v "${target_bitrate}k" -pass 1 -an -f null /dev/null && \
    #     ffmpeg -i "$input_file" -c:v libx264 -b:v "${target_bitrate}k" -pass 2 -b:a 128k "$output_file"
#
# if [ $? -ne 0 ]; then
#     echo "Error: ffmpeg command failed."
#     exit 1
# fi
#
# echo "Compression complete. Output file: $output_file"
# }


# function vidToTarMb2() {
#     input_file="$1"
#     target_size_mb="$2"
#     output_file="${input_file%.*}_compressed.mp4"
#
#     if [ -z "$input_file" ] || [ -z "$target_size_mb" ]; then
#         echo "Usage: $0 <input_video_file> <target_size_in_MB>"
#         exit 1
#     fi
#
#     # Get the width and height from the video using ffprobe
#     dimensions=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input_file")
#
#     if [ $? -ne 0 ]; then
#         echo "Error: ffprobe command failed."
#         exit 1
#     fi
#
#     # Assign dimensions directly to width and height variables
#     IFS='x' read -r width height <<< "$dimensions"
#
#     width=$((width))
#     height=$((height))
#
#     echo "Video Dimensions: ${width}x${height}"
#
#     # Calculate the target bitrate based on the input target size
#     denominator=$((width * height + 1))
#
#     if [ "$denominator" -le 0 ]; then
#         echo "Error: Invalid denominator for bitrate calculation."
#         exit 1
#     fi
#     echo "Denominator: $denominator"
#
#     # Calculate target bitrate with floating-point arithmetic
#     target_bitrate=$(echo "$target_size_mb * 8192 / $denominator" | bc)
#
#     # If the calculated bitrate is below the threshold, dynamically adjust the scale
#     while (( $(echo "$target_bitrate < 2000" | bc -l) )); do
#         echo "Bitrate below 1000k. Reducing video scale..."
#         width=$(( (width * 95 / 100 / 2) * 2 ))
#         height=$(( (height * 95 / 100 / 2) * 2 ))
#         target_bitrate=$(echo "$target_size_mb * 8192 / ($width * $height + 1)" | bc)
#     done
#
#     echo "Target Bitrate: ${target_bitrate}k"
#     echo "Dims ${width} ${height}"
#
#     ffmpeg -i "$input_file" -vf "scale=$width:$height" -c:a copy "$output_file"
#     echo "Rescaling complete. Output file: $output_file"
# }

function gif2mp4() {
    # https://unix.stackexchange.com/a/294892
    input=$1
    output=$2
    ffmpeg -i "$input" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$output"
}



