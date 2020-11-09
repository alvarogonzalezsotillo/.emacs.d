INFILE="$1"
OUTFILE="$2"

if [ $# -ne 2 ]
then
    echo "USO: <infile> <outfile>"
    exit 1
fi   

#ffmpeg -i "$INFILE" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "$OUTFILE"
 ffmpeg -i "$INFILE" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p -s 640x360 "$OUTFILE"
