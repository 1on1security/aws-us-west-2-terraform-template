#!/usr/bin/env bash
# generate fresh ssh keys prior to template deployment.

# location of the script file to update
public_serverScriptFile=bash/public_server.bash
private_serverScriptFile=bash/private_server.bash

echo "This script is meant to be executed in the root folder of the gitlab project."
read -n 1 -s -r -p "Press any key to continue..."

if [ -d "KEYS" ]; then
    mkdir KEYS
fi

if [ -d "bash" ]; then
    mkdir bash
fi

echo "Generating new SSH Key..."
ssh-keygen -f KEYS/aws.template-key -t ecdsa -b 521 -C aws_template@mydomain.com

newSSHKey=$(cat KEYS/aws.template-key.pub)
echo "Copying the new public key into the bash scripts which deploy them on the servers via terraform."
echo "hostnamectl set-hostname server.mydomain.com" > $public_serverScriptFile
echo -e $newSSHKey >> $public_serverScriptFile
echo "hostnamectl set-hostname private.mydomain.priv" > $private_serverScriptFile
echo -e $newSSHKey >> $private_serverScriptFile

