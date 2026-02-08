terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "security" {
  name = "my-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_instance" "main" {
  ami                         = "ami-04233b5aecce09244"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private-subnet.id
  associate_public_ip_address = false // i am forcing that ec2 instance jab banega tab public ip nahi banana hai
  depends_on                  = [aws_security_group.security]

  lifecycle {
    //create_before_destroy = true
    //prevent_destroy = true
    //replace_triggered_by = [aws_security_group.security, aws_security_group.security.ingress]

    precondition {
      condition     = aws_security_group.security.id != "" //should not be blank
      error_message = "Security group ID must not be blank"
    }

    postcondition {                        // check after ec2 creation do we have public ip or not. If not there then give error
      condition     = self.public_ip != "" //public ip not equal to blank
      error_message = "Public IP is not present"
    }

  }
}
