#!/bin/bash


for MINUTO in $(seq 0 $(("$1"-1)))
do
    figlet Quedan $(("$1"-"$MINUTO")) minutos
    sleep 1m
done

espeak-ng "Time out"
