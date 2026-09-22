

distrobox create --image ubuntu:22.04 --home /home/alvaro/distrobox-office --name ubuntu-office2010 --hostname ubuntu-office2010 --volume /datos-luks:/datos-luks 

distrobox enter ubuntu-office2010 

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install wine32 samba winbind

