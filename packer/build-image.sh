#!/bin/bash
# source from: https://developer.hashicorp.com/packer/tutorials/docker-get-started/docker-get-started-build-image

echo "it's going to create directory packer-tutorial"
mkdir packer-tutorial

cd packer-tutorial 

touch docker-ubuntu.pkr.hcl

echo "wrting command to hcl file...."
echo '
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
  commit = true
}

build {
  name    = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]
}
' > docker-ubuntu.pkr.hcl

echo "writing done!"

echo "initiating packer environment...."
packer init . 
echo "initiation done!"

echo "formatting packer template...."
packer fmt .
echo "formatting done!"

echo "validating template..."
packer validate .
echo "validation done!"

packer build docker-ubuntu.pkr.hcl

docker images 

echo "After executed above command, you can remove the images by executing following command, replace IMAGE_ID with actual image id."
echo "docker rmi IMAGE_ID"