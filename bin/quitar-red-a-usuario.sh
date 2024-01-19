#!/bin/bash

mis_ip(){
    cat <(echo 127.0.0.0/24) <(hostname -I)
}

prohibir_dos(){
    echo "
      Evito algunos problemas de ataques DOS. 
      Ver https://www.digitalocean.com/community/tutorials/how-to-set-up-a-basic-iptables-firewall-on-centos-6
    "
    iptables --append MICADENAENTRADA --protocol tcp --tcp-flags ALL NONE --jump DROP
    iptables --append MICADENAENTRADA --protocol tcp ! --syn --match state --state NEW --jump DROP
    iptables --append MICADENAENTRADA --protocol tcp --tcp-flags ALL ALL --jump DROP
}

permitir_loopback(){
    echo "
      Toda la comunicación entrante y saliente por loopback se permite
      Así consigo que una conexión ssh realice túneles a esta misma máquina
    "
    iptables --append MICADENAENTRADA --in-interface lo --jump ACCEPT
    iptables --append MICADENAENTRADA --out-interface lo --jump ACCEPT    
}

permitir_puerto_entrada(){
    local PUERTO=$1
    iptables --append MICADENAENTRADA --protocol tcp --match tcp --dport $PUERTO --jump ACCEPT
    iptables --append MICADENAENTRADA --protocol tcp --match tcp --sport $PUERTO --jump ACCEPT    
}

prohibir_entrada_y_salida(){
    echo "
      Todas las comunicaciones tcp de entrada y salida se prohiben.
      Esta debería ser la última regla, así que si no se ha admitido antes un paquete, ya no se admite
    "
    iptables --append MICADENAENTRADA --protocol tcp --jump DROP
    iptables --append MICADENASALIDA --protocol tcp --jump DROP    

}


permitir_servidor_web(){
    echo "
      Permito puertos de servidor web: 80, 8080 y 443.
    "
    permitir_puerto_entrada 80
    permitir_puerto_entrada 8080
    permitir_puerto_entrada 443
}

permitir_servidor_vnc(){
    echo "
      Permito puertos de vnc: 5900, 5901, 5902
    "
    permitir_puerto_entrada 5900
    permitir_puerto_entrada 5901
    permitir_puerto_entrada 5902
}

permitir_servidor_oracle(){
    echo "
      Permito puertos de servidor oracle: 1521
    "
    permitir_puerto_entrada 1521
}


permitir_servidor_ssh(){
    echo "
      Permito entrar por ssh: puerto 22
    "
    permitir_puerto_entrada 22
}

permitir_email(){
    echo "
      Permito entrar por email: puerto 25
    "
    permitir_puerto_entrada 25
}



permitir_usuario_root(){
    echo "
      El usuario root tiene permitida cualquier comunicación de salida.
      También los del grupo wheel, administrador de centos.
      Tabmién alvaro, el usuario del profesor.
    "
    iptables --append MICADENASALIDA --match owner --uid-owner root --jump ACCEPT
    iptables --append MICADENASALIDA --match owner --uid-owner alvaro --jump ACCEPT
    iptables --append MICADENASALIDA --match owner --uid-owner profesor --jump ACCEPT
    iptables --append MICADENASALIDA --match owner --gid-owner sudo --jump ACCEPT
    iptables --append MICADENASALIDA --match owner --uid-owner _apt --jump ACCEPT
}

enviar_paquetes_salida_a_log(){
    echo "
      Los paquetes que llegan los mando a syslog.
      Se pueden consultar con tail -f /var/log/messages | grep -i iptables
    "
    iptables --append MICADENAENTRADA --match limit --limit 2/min --jump LOG --log-prefix "IPTables-output-dropped: " --log-level 4   
}

limpiar_iptables(){
    echo "
      Limpio mi cadena y la conecto a la entrada
    "
    iptables --flush MICADENAENTRADA
    iptables --new-chain MICADENAENTRADA
    
    iptables --flush MICADENASALIDA
    iptables --new-chain MICADENASALIDA
    
    iptables --append OUTPUT --jump MICADENASALIDA
    iptables --append INPUT --jump MICADENAENTRADA
}

permitir_ya_establecido(){
    echo "
      Permitir conexiones ya establecidas
    "
    iptables --insert MICADENAENTRADA --match state --state ESTABLISHED,RELATED --jump ACCEPT
}

if [ "$1" = "limpiar" ]
then
    limpiar_iptables
    exit 1
fi    

limpiar_iptables
permitir_ya_establecido
permitir_loopback
prohibir_dos
permitir_servidor_ssh
permitir_email
permitir_servidor_web
permitir_servidor_oracle
permitir_usuario_root
permitir_servidor_vnc
enviar_paquetes_salida_a_log
prohibir_entrada_y_salida

iptables-save > iptables-save

service iptables save

echo Docker habrá que reiniciarlo
