#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt update

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
