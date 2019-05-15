for fichero in $*
do
    echo $fichero
    
    ficherosinextension=${fichero%.*}
    echo $ficherosinextension
    dirname "$fichero"
    inkscape --export-area-drawing --export-plain-svg="$ficherosinextension.svg" "$fichero"
done
