#!/bin/bash
if [ $# -lt 2 ]; then
    echo "missing arguments:"
    echo "usage $0 <video> <options>"
    exit 1
fi

video=$1
output_video=$2
base=$(basename "$output_video")
extension="${base##*.}"
base_filename="${base%.*}"
transform_file="converted/$base_filename.trf"
output_merged="converted/$base_filename-stb$opts-merged.$extension"

echo "ffmpeg -i $video $options -vf vidstabdetect=shakiness=8:accuracy=15:result=$transform_file -f null -"

echo "Options"
echo $options
echo "==="

if [ -z "$options" ]; then
    echo "No time limit"
    ffmpeg -y -i $video -vf vidstabdetect=shakiness=5:accuracy=15:result=$transform_file -f null -
    ffmpeg -y -i $video -vf \
        vidstabtransform=smoothing=5:interpol=bicubic:input=$transform_file,unsharp=5:5:0.8:3:3:0.4 $output_video
    ffmpeg -y -i $video -i $output_video -filter_complex "[0:v:0]pad=iw*2:ih[bg]; [bg][1:v:0]overlay=w" $output_merged
fi

if [ -n "$options" ]; then
    echo "Time limit"
    ffmpeg -y -i $video $options -vf vidstabdetect=shakiness=5:accuracy=15:result=$transform_file -f null -
    ffmpeg -y -i $video $options -vf \
        vidstabtransform=smoothing=5:interpol=bicubic:input=$transform_file,unsharp=5:5:0.8:3:3:0.4 $output_video
    ffmpeg -y $options -i $video -i $output_video -filter_complex "[0:v:0]pad=iw*2:ih[bg]; [bg][1:v:0]overlay=w" $output_merged
fi
