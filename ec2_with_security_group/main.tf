terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}


provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "web_server" {
    ami = "ami-0cca134ec43cf708f"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = "web-server"
    associate_public_ip_address = true

    root_block_device{
        volume_type = "gp2"
        volume_size = "8"
        delete_on_termination = true
    }
    
    tags = {
      "Name" = "web-server"
    }
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"
  description = "allow/decline traffic"
 
  dynamic "ingress" {
    for_each = [22,80,443]
    iterator = port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sg"
  }
}
