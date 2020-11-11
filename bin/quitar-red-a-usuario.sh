#!/bin/bash

USUARIO="$1"
OPERACION="$2"

mis_ip(){
    cat <(echo 127.0.0.0/24) <(hostname -I)
}

grupo_alumnos(){
    groupadd --force alumnos-sin-red
}

meter_usuario_en_grupo(){
    USUARIO=$1
    GRUPO=$2
    usermod -a -G $GRUPO $USUARIO
}

SUDO(){
    echo "$*"
    sudo $*
}


if [ "$USUARIO" = "" ]
then
    echo Se necesita usuario a limitar
    exit 1
fi

if [ "$OPERACION" = "" ]
then
    OPERACION=--append
fi

if [ "$OPERACION" != "--append" ] && [ "$OPERACION" != '--delete' ]
then
    echo "La operación tiene que ser --append (quitar red ) o --delete (devolver red)"
    exit 2
fi

for IP in $(mis_ip)
do
    SUDO iptables "$OPERACION" OUTPUT --protocol all --destination "$IP" --match owner --uid-owner "$USUARIO" --jump ACCEPT
done
SUDO iptables "$OPERACION" OUTPUT --protocol all --match owner --uid-owner "$USUARIO" --jump DROP

sudo iptables-save
