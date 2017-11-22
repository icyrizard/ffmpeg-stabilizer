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

    #echo $output_video
    echo $video
    original_video=$(echo $output_video| sed 's/\(.*\)\(-stb.*\)\(.MOV$\)/\1\3/g')
    #echo $derp
    echo $tmpIFS
    IFS=$tmpIFS

    if [ -z "$options" ]; then
        VIDEO=$video make $output_video ;
    fi

    if [ -n "$options" ]; then
        VIDEO=$video OPTIONS=$options make $output_video ;
    fi

done < "$1"

#   for t in $ALL_TARGETS; do IFS=" " ;
#       video=`echo $$t | cut -f1 -d ','`
#       options=`echo $$t | cut -f2 -d ','`
#       base=`basename $video`
#       extension=MOV
#       base_filename=`echo $base | sed 's/.MOV//g'`
#       transform_file="converted/$base_filename.trf"
#       opts=`echo $options | sed 's/\ //g'`
#       opts=`echo $opts | sed 's/:/-/g'`
#       output_video="$base_filename-stb$opts.$extension"
#       output_merged="$base_filename-stb$opts-merged.$extension"
#       #MOVIE=echo $t | cut -f1 -d ',' "OPT=${echo $t | cut -f2 -d ','}" make $output_video
#   done
