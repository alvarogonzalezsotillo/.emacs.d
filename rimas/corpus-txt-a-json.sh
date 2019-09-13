doit(){
    echo '// -*- mode: fundamental; -*-'
    echo 'export const corpusByFrequency = ['
    for linea in $(cat ./corpus-por-frecuencia.txt)
    do
        echo '"'$linea'",'
    done;

    echo ' "chipún" ];'
}

echo DOING...
doit > corpus-by-frequency.mjs
echo DONE
