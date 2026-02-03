terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version  = ">= 1.2"
}

provider "aws" {
  region = "us-west-2"
}

# VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["us-west-2a", "us-west-2b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_dns_hostnames = true
}

# Security Group
resource "aws_security_group" "main_sg" {
  name   = "main_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# EC2 Instance
resource "aws_instance" "ubuntu_instance" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.main_sg.id]
  associate_public_ip_address = true
  user_data = templatefile("install_nginx.tftpl", {})

  tags = {
    Name = "UbuntuServer"
  }
}

