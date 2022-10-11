#!/bin/bash -x
AULA=a33
USUARIOALUMNO=alumnom

for PC in $(seq 1 16)
do
    PC=$(printf "%02d" $PC)
    ssh profesor@${AULA}pc${PC}.local "sh -c \"sudo -u $USUARIOALUMNO nohup env -v DISPLAY=:0.0 epoptes-client & \" "
done
