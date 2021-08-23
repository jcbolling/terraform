#!/bin/bash

# Update instance

/usr/bin/sudo yum update -y

# Install aws cli

/usr/bin/pip3 install aws

# Install Ansible

/usr/bin/pip3 install ansible