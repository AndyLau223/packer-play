#!/bin/bash
# source from: https://developer.hashicorp.com/packer/tutorials/docker-get-started/docker-get-started-build-image
# Note that: Be careful ! This script will delete all iamges after it's done for space saving purpose.

chmod +x ./docker-ubuntu.pkr.hcl

echo "initiating packer environment...."
packer init . 
echo "initiation done!"
echo

echo "formatting packer template...."
packer fmt .
echo "formatting done!"
echo

echo "validating template..."
packer validate .
echo "validation done!"
echo

# Parameterized templated: A couple of ways to build images with variable

# 1
# normal build, not external confugration
# packer build docker-ubuntu.pkr.hcl

# 2
# build with a  variable file
# packer build --var-file=example.auto.pkrvars.hcl docker-ubuntu.pkr.hcl

# 3
# Packer will load any variable file automatically that matches the name *.auto.pkrvars.hcl
# packer build .

# 4 
# give the variable in command line.
packer build --var docker_image=ubuntu:groovy .
echo

# Starting to clean up for space saving purpose since this is a experiment learning script.
docker images 
echo 

echo "Starting to clean up for space saving purpose since this is a experiment learning script."
echo 'Executing "docker rmi -f $(docker images -aq)"'
echo 


docker rmi -f $(docker images -aq)
echo "All done!"
echo 