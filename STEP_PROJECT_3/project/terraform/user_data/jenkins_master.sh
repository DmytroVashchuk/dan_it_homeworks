#!/bin/bash

sudo apt update -y
sudo apt install -y openjdk-11-jdk
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
