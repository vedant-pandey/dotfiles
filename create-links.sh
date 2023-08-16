#!/bin/bash

trap 'echo "Interrupt found exiting"' 1 2 3 6 15

# # Config folder
# stow -Rvt ~/.config config
#
# # Home folder
# stow -Rvt ~ home
#
mkdir test
cp -r ssh test
cd test/ssh

$(ansible-vault decrypt *)&>/dev/null

if [ $? -eq 0]; then
    echo "Decryption Sucessful"
else
    echo "Decryption failed, removing unused files"
#     cd ../..
#     rm -r test
#     echo "Files cleaned"
fi
