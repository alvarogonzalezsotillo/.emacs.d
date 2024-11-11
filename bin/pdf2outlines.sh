INFILE="$1"
OUTFILE="$2"

if [ $# -ne 2 ]
then
    echo "USO: <infile> <outfile>"
    exit 1
fi   

gs -dNoOutputFonts -r720 -sDEVICE=pdfwrite -o "$OUTFILE" "$INFILE"
