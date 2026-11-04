#!/bin/bash
mkdir -p "$HOME/distrobox-homes/ubuntu"
distrobox create --name ubuntu --image ubuntu:latest --home "$HOME/distrobox-homes/ubuntu" --hostname ubuntu
