#!/bin/bash


list_repos(){
    dnf repolist --quiet | awk '{print $1}'
}


disable_repos(){
    # Disable all repositories using dnf config-manager
    for repo in $(cat); do
        sudo dnf config-manager setopt "$repo.enabled=0"
        echo "Disabled repository: $repo"
    done
}



list_repos | disable_repos
