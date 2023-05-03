terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {}

resource "null_resource" "packer" {
  provisioner "local-exec" {
    command = "packer build theimage.json"
  }
}