#!/bin/bash


list_repos(){
    dnf repolist --all --quiet | awk '{print $1}'
}


enable_repos(){
    # Disable all repositories using dnf config-manager
    for repo in $(cat); do
        sudo dnf config-manager setopt "$repo.enabled=1"
        echo "Enabled repository: $repo"
    done
}



list_repos | enable_repos
