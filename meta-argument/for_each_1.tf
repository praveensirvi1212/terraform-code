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
  instances = tomap({
      "web-server" = "ami-0cca134ec43cf708f"
      "test-server" = "ami-06984ea821ac0a879"
      "database-server" = "ami-079b117c1800d30f8"
})
}


resource "aws_instance" "web-server" {
  for_each = local.instances
  ami           = "${each.value}"
  instance_type = "t2.micro"
  tags = {
    Name = "${each.key}"
  }

}
