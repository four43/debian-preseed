#!/bin/bash

if [ "${BASH_SOURCE[0]}" -ef "$0" ]
then
    echo "This script should be sourced, not executed." >&2
    exit 1
fi

export DEBIAN_PS_DISK="/dev/sda"

export DEBIAN_PS_FULL_NAME="Zap Brannigan"
export DEBIAN_PS_USERNAME='zbrannigan'
#export DEBIAN_PS_PASSWORD="$(mkpasswd -m sha-512 -S $(pwgen -ns 16 1) plaintextPassword)"
export DEBIAN_PS_PASSWORD='$6$wNALA5LqtuzAJSmU$QWjyXJleXYaxx0j4VN5rASu2kwjHpQVM0nbyLH1QaFUo8UmXblHLMk7xcP6eyA9WbzCxtQT0rXX/.q7f5p0os/'
export DEBIAN_PS_PUB_KEY='ssh-rsa somereallylongsshkey zap@numbus.doop.gov'
