packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

# define variable, and give it default value
# This can be overrided by external configuration file
variable "docker_image" {
  type    = string
  default = "ubuntu:xenial"
}


source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

source "docker" "ubuntu-bionic" {
  image  = "ubuntu:bionic"
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    # The parallel build in pakcer is out of box, amazing!
    "source.docker.ubuntu",
    "source.docker.ubuntu-bionic",
  ]
  # provisioner run in the order as they declared.
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
  provisioner "shell" {
    inline = ["echo Running ${var.docker_image} Docker image."]
  }

  # post-processor can do veried things, like compress artifact, upload artifact to cloud etc.
  post-processor "docker-tag" {
    repository = "learn-packer"
    tags       = ["ubuntu-xenial", "dev"]
    only       = ["docker.ubuntu"]
  }
  post-processor "docker-tag" {
    repository = "learn-packer"
    tags       = ["ubuntu-bionic", "uat"]
    only       = ["docker.ubuntu-bionic"]
  }
}