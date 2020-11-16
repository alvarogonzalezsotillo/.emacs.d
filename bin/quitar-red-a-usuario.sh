#!/bin/bash

mis_ip(){
    cat <(echo 127.0.0.0/24) <(hostname -I)
}

prohibir_dos(){
    local msg="
      Evito algunos problemas de ataques DOS. 
      Ver https://www.digitalocean.com/community/tutorials/how-to-set-up-a-basic-iptables-firewall-on-centos-6
    "
    echo "$msg"
    iptables --append INPUT --protocol tcp --tcp-flags ALL NONE --jump DROP
    iptables --append INPUT --protocol tcp ! --syn --match state --state NEW --jump DROP
    iptables --append INPUT --protocol tcp --tcp-flags ALL ALL --jump DROP
}

permitir_loopback(){
    local msg="
      Toda la comunicación entrante y saliente por loopback se permite
      Así consigo que una conexión ssh realice túneles a esta misma máquina
    "
    echo "$msg"
    iptables --append INPUT --in-interface lo --jump ACCEPT
    iptables --append OUTPUT --out-interface lo --jump ACCEPT    
}

permitir_puerto_entrada(){
    local PUERTO=$1
    iptables --append INPUT --protocol tcp --match tcp --dport $PUERTO --jump ACCEPT
}

prohibir_entrada_y_salida(){
    local msg="
      Todas las comunicaciones tcp de entrada y salida se prohiben.
      Esta es la última regla, así que si no se ha admitido antes un paquete, ya no se admite
    "
    echo "$msg"
    iptables --append INPUT --protocol tcp --jump DROP
    iptables --append OUTPUT --protocol tcp --jump DROP    
}


permitir_servidor_web(){
    local msg="
      Permito puertos de servidor web: 80 y 443.
    "
    echo "$msg"
    permitir_puerto_entrada 80
    permitir_puerto_entrada 443
}

permitir_servidor_oracle(){
    local msg="
      Permito puertos de servidor oracle: 1521
    "
    echo "$msg"
    permitir_puerto_entrada 1521
}


permitir_servidor_ssh(){
    local msg="
      Permito entrar por ssh: puerto 22
    "
    echo "$msg"
    permitir_puerto_entrada 22
}



permitir_usuario_root(){
    local msg="
      El usuario root tiene permitida cualquier comunicación de salida.
      También los del grupo wheel, administrador de centos.
    "
    echo "$msg"
    
    iptables --append OUTPUT --match owner --uid-owner root --jump ACCEPT
    iptables --append OUTPUT --match owner --uid-owner alvaro --jump ACCEPT
    iptables --append OUTPUT --match owner --gid-owner wheel --jump ACCEPT
}

enviar_paquetes_salida_a_log(){
    local msg="
      Los paquetes que llegan los mando a syslog.
      Se pueden consultar con tail -f /var/log/messages | grep -i iptables
    "
    echo "$msg"
    iptables --append OUTPUT --match limit --limit 2/min --jump LOG --log-prefix "IPTables-output-dropped: " --log-level 4   
}

limpiar_iptables(){
    local msg="
      Limpio las tablas, todo está permitido
    "
    echo "$msg"
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -t nat -F
    iptables -t mangle -F
    iptables -F
    iptables -X
}

permitir_ya_establecido(){
    local msg="
      Permitir conexiones ya establecidas
    "
    echo "$msg"
    iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
}

if [ "$1" = "limpiar" ]
then
    limpiar_iptables
    exit 1
fi    

limpiar_iptables
permitir_loopback
prohibir_dos
permitir_servidor_ssh
permitir_servidor_web
permitir_servidor_oracle
permitir_usuario_root
permitir_ya_establecido
enviar_paquetes_salida_a_log
prohibir_entrada_y_salida

iptables-save > iptables-save
