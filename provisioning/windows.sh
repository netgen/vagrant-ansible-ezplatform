#!/usr/bin/env bash

if [ $(dpkg-query -W -f='${Status}' ansible 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    echo "Add APT repositories"
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -y python3-software-properties
    sudo apt-get install -y python3-setuptools
    sudo apt-get install -y python3-pip

    echo "Installing Ansible"
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    sudo add-apt-repository http://ppa.launchpad.net/ansible/ansible/ubuntu
    sudo apt-get update
    sudo apt-get install -y ansible
    echo "Ansible installed"
fi

ansible-playbook /vagrant/provisioning/vagrant.yml -c local -i localhost,