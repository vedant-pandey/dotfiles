trap 'echo "Interrupt found exiting"' 1 2 3 6 15
mkdir test
cp -r ssh test
cd test/ssh
ansible-vault decrypt *
