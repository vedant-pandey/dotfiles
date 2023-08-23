#!/bin/bash

if [[ -z $1 ]]; then
    echo "Usage: ./create-links.sh [-c] [-h] [-s] [-a]"
    echo -e "-a: Link all"
    echo -e "-c: Link config"
    echo -e "-h: Link home"
    echo -e "-s: Link ssh"
    exit 1
fi

echo -e "INIT LINKING CONFIGS\n"
stow -nRvt ~/.config config
echo -e "\nDONE LINKING CONFIGS\n"
echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"

echo -e "INIT LINKING HOME FILES\n"
stow -nRvt ~ home
echo -e "\nDONE LINKING HOME FILES\n"
echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"

echo -e "INIT LINKING SSH KEYS\n"
cd decrypted
stow -nRvt ~/.ssh ssh
echo -e "\nDONE LINKING SSH KEYS\n"
echo -e "~~~~~~~~~~~~~~~~~~~~~~~\n"
