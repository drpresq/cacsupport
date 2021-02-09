#!/bin/bash

function export_pubkey {
	pkcs15-tool --read-ssh-key 01  -o $HOME/id_piv.pub
}

echo -e "\n\nExtracted CAC SSH Keys to $HOME/authorized_keys\n"
export_pubkey

echo -e "\n\nUse command 'ssh-id-copy -i $HOME/id_piv.pub user@server' to install your ssh key onto desired ssh targets.\n"

