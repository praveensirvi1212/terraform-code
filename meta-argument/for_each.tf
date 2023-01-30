terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
}

locals {
  instance_names = toset(["build-server","test-server","web-server"])
}


resource "aws_instance" "web-server" {
  for_each = local.instance_names
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
  tags = {
    Name = "${each.key}"
  }

}


#output "ec2_public_ips" {
#   value = aws_instance.web-server[*].public_ip   #for multiple ips [*] its array
#    value = aws_instance.web-server.public_ip
#  
#}
