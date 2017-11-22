#!/bin/bash
if [ $# -ne 1 ]; then

    echo "missing arguments:"
    echo "usage $0 <list>"
    exit 1
fi

tmpIFS=$IFS

while IFS='' read -r var
do
    video=`echo "$var" | cut -f1 -d ','`
    video=`echo $video | sed 's/,//g'`
    options=`echo "$var" | cut -f2 -d ','`
    base=$(basename "$video")
    extension="${base##*.}"
    base_filename="${base%.*}"
    transform_file="converted/$base_filename.trf"
    opts=$(echo $options | sed 's/\ //g')
    opts=$(echo $opts| sed 's/:/-/g')
    opts=$(echo $opts| sed 's/\"//g')
    output_video="converted/$base_filename-stb$opts.$extension"
    output_merged="converted/$base_filename-stb$opts-merged.$extension"

    # restore IFS
    IFS=$tmpIFS

    if [ -z "$options" ]; then
        VIDEO=$video make $output_video ;
    fi

    if [ -n "$options" ]; then
        VIDEO=$video OPTIONS=$options make $output_video ;
    fi

done < "$1"
