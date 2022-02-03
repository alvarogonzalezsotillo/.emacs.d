#!/bin/bash

mis_ip(){
    cat <(echo 127.0.0.0/24) <(hostname -I)
}

prohibir_dos(){
    echo "
      Evito algunos problemas de ataques DOS. 
      Ver https://www.digitalocean.com/community/tutorials/how-to-set-up-a-basic-iptables-firewall-on-centos-6
    "
    iptables --append INPUT --protocol tcp --tcp-flags ALL NONE --jump DROP
    iptables --append INPUT --protocol tcp ! --syn --match state --state NEW --jump DROP
    iptables --append INPUT --protocol tcp --tcp-flags ALL ALL --jump DROP
}

permitir_loopback(){
    echo "
      Toda la comunicación entrante y saliente por loopback se permite
      Así consigo que una conexión ssh realice túneles a esta misma máquina
    "
    iptables --append INPUT --in-interface lo --jump ACCEPT
    iptables --append OUTPUT --out-interface lo --jump ACCEPT    
}

permitir_puerto_entrada(){
    local PUERTO=$1
    iptables --append INPUT --protocol tcp --match tcp --dport $PUERTO --jump ACCEPT
    iptables --append OUTPUT --protocol tcp --match tcp --sport $PUERTO --jump ACCEPT    
}

prohibir_entrada_y_salida(){
    echo "
      Todas las comunicaciones tcp de entrada y salida se prohiben.
      Esta debería ser la última regla, así que si no se ha admitido antes un paquete, ya no se admite
    "
    iptables --append INPUT --protocol tcp --jump DROP
    iptables --append OUTPUT --protocol tcp --jump DROP    
}


permitir_servidor_web(){
    echo "
      Permito puertos de servidor web: 80, 8080 y 443.
    "
    permitir_puerto_entrada 80
    permitir_puerto_entrada 8080
    permitir_puerto_entrada 443
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



permitir_usuario_root(){
    echo "
      El usuario root tiene permitida cualquier comunicación de salida.
      También los del grupo wheel, administrador de centos.
      Tabmién alvaro, el usuario del profesor.
    "
    iptables --append OUTPUT --match owner --uid-owner root --jump ACCEPT
    iptables --append OUTPUT --match owner --uid-owner alvaro --jump ACCEPT
    iptables --append OUTPUT --match owner --gid-owner wheel --jump ACCEPT
}

enviar_paquetes_salida_a_log(){
    echo "
      Los paquetes que llegan los mando a syslog.
      Se pueden consultar con tail -f /var/log/messages | grep -i iptables
    "
    iptables --append OUTPUT --match limit --limit 2/min --jump LOG --log-prefix "IPTables-output-dropped: " --log-level 4   
}

limpiar_iptables(){
    echo "
      Limpio las tablas, todo está permitido
    "
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -t nat -F
    iptables -t mangle -F
    iptables -F
    iptables -X
}

permitir_ya_establecido(){
    echo "
      Permitir conexiones ya establecidas
    "
    iptables --insert INPUT --match state --state ESTABLISHED,RELATED --jump ACCEPT
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
permitir_servidor_web
permitir_servidor_oracle
permitir_usuario_root
enviar_paquetes_salida_a_log
prohibir_entrada_y_salida

iptables-save > iptables-save

service iptables save
