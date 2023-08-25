#!/bin/bash

if [[ -z $1 ]]; then
    echo "Illegal option"
    echo "Usage: ./create-links.sh [-c] [-h] [-s] [-a]"
    echo -e "-a: Link all"
    echo -e "-c: Link config"
    echo -e "-h: Link home"
    echo -e "-s: Link ssh"
    exit 1
fi

# if [[ ! " ${array[@]} " =~ " -a " ]] && [[ ! " ${array[@]} " =~ " -c " ]] && [[ ! " ${array[@]} " =~ " -h " ]] && [[ ! " ${array[@]} " =~ " -s " ]]; then
#     echo "Invalid flags"
#     exit 1
# fi

LINK_ALL=false
LINK_CONFIG=false
LINK_SSH=false
LINK_HOME=false

if echo $* | grep -e "-a" -q; then
    LINK_ALL=true
elif echo $* | grep -e "-c" -q; then
    LINK_CONFIG=true
elif echo $* | grep -e "-h" -q; then
    LINK_HOME=true
elif echo $* | grep -e "-s" -q; then
    LINK_SSH=true
else
    echo "Invalid flag(s)"
fi

if $LINK_ALL || $LINK_CONFIG; then
    echo -e "INIT LINKING CONFIGS\n"
    stow -nRvt ~/.config config
    echo -e "\nDONE LINKING CONFIGS\n"
    echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"
fi

if $LINK_ALL || $LINK_HOME; then
    echo -e "INIT LINKING HOME FILES\n"
    stow -nRvt ~ home
    echo -e "\nDONE LINKING HOME FILES\n"
    echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"
fi

if $LINK_ALL || $LINK_SSH; then
    echo -e "INIT LINKING SSH KEYS\n"
    cd decrypted
    stow -nRvt ~/.ssh ssh
    echo -e "\nDONE LINKING SSH KEYS\n"
    echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"
fi
