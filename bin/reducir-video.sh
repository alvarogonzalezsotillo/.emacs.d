#!/bin/sh
INPUT="$1"
OUTPUT="$2"
ffmpeg -i "$INPUT" -vcodec libx264 -crf 24 "$OUTPUT" 
