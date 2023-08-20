#!/bin/bash

echo "INIT LINKING CONFIGS"
echo ""
stow -nRvt ~/.config config
echo ""
echo "DONE LINKING CONFIGS"
echo "~~~~~~~~~~~~~~~~~~~~~~~"

echo "INIT LINKING HOME FILES"
echo ""
stow -nRvt ~ home
echo ""
echo "DONE LINKING HOME FILES"
echo "~~~~~~~~~~~~~~~~~~~~~~~"

echo "INIT LINKING SSH KEYS"
echo ""
cd decrypted
stow -nRvt ~/.ssh ssh
echo ""
echo "DONE LINKING SSH KEYS"
echo "~~~~~~~~~~~~~~~~~~~~~~~"
