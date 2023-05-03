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
data "aws_ami" "example" {
  most_recent      = true
  owners           = ["001613358280"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  depends_on=[null_resource.packer]
}

output "ami"{
  value=data.aws_ami.example.name
}
