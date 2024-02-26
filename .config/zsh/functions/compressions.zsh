#!/bin/zsh

function compPdf() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=out"${$1}".pdf "${$1}"
}

function svgocp {
    input=$1
    svgo --config=""${HOME}"/.config/svgo.config.js" -i "${input}" -o - | pbcopy
    echo "Optimised and copied "${input}" (if you provided a valid file). Check clipboard."
}

function slugit() {
    for file in *."$1"; do
        filename=${file%.*}
        test=$(slugify $filename | sed -e 's/\r//g')
        newname="$test.$1"
        mv "$file" "$newname"
    done
}
function optimiseit() {
    for i in *; do
        slugged=$(slugify ${i%.*} | sed -e 's/\r//g')
        if [ "$i" != "$slugged" ]
        then
            convert $i -resize 1920x1080 -quality 90 $slugged.jpg
            rm $i
        fi
    done
}

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



function compressInTriplicate() {
    IMAGE_DIR="$1"

    # Define the three default dimensions to which the images should be compressed
    SMALL_DIMENSIONS=(800x600 640x480 320x240)
    MEDIUM_DIMENSIONS=(1024x768 800x600 640x480)
    LARGE_DIMENSIONS=(1600x1200 1280x960 1024x768)

    # Check if the user has specified small, medium, or large images
    if [[ "$2" == "small" ]]; then
        DIMENSIONS=("${SMALL_DIMENSIONS[@]}")
    elif [[ "$2" == "medium" ]]; then
        DIMENSIONS=("${MEDIUM_DIMENSIONS[@]}")
    elif [[ "$2" == "large" ]]; then
        DIMENSIONS=("${LARGE_DIMENSIONS[@]}")
    else
        # Use the default dimensions if no optional parameter is specified
        DIMENSIONS=("${MEDIUM_DIMENSIONS[@]}")
    fi

    # quality setting
    if [ -n "$3" ] && [ "$3" -eq "$3" ] 2>/dev/null; then
        QUAL=$3
    else
        echo QUAL=90
    fi

    # Create the compressed directory if it doesn't exist
    mkdir -p ${IMAGE_DIR}/compressed

    # Loop through the dimensions and compress the images
    for SIZE in "${DIMENSIONS[@]}"; do
        # Loop through the images in the directory
        for FILE in "${IMAGE_DIR}"/*.*; do
            # Get the file extension
            EXTENSION="${FILE##*.}"

            # Check if the file is an image
            if [[ "$EXTENSION" =~ ^(jpg|jpeg|png|gif)$ ]]; then
                # Get the file name without the extension
                FILENAME="${FILE%.*}"

                # Convert the file name to a slug
                SLUG="$(slugify "$(basename "${FILENAME}")")"
                DIMENSIONINDEX=0
                for I in "${DIMENSIONS[@]}"; do
                    if [[ "${I}" == "${SIZE}" ]]; then
                        if [[ "${DIMENSIONINDEX}" == "0" ]]; then
                            LABEL="lg"
                        elif [[ "${DIMENSIONINDEX}" == "1" ]]; then
                            LABEL="md"
                        else
                            LABEL="sm"
                        fi
                    fi
                    (( DIMENSIONINDEX++ ))
                done

                # Use ImageMagick to resize the image to the specified dimensions and save it to the compressed directory
                convert "${FILE}" -resize "${SIZE}^" -quality ${QUAL} -gravity center -extent "${SIZE}" "${IMAGE_DIR}/compressed/${SLUG}_${LABEL}.${EXTENSION}"
            fi
        done
    done
}
