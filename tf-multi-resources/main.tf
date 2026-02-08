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

locals {
  project = "shubh"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.my-vpc.id
  //cidr_block = "10.0.0.0/24" //we cant use the same ip block for 10 subnet, we have to increase count
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
    //${count.index} - index is like a array which start from 0. count is 2. So, index starts from 0, 1, 2. output will be like dev-subnet-0, then dev-subnet-1
  }
}

output "aws_subnet_id" {
  value = aws_subnet.subnet[1].id
}

/* This was for Create 2 subnets, create 4 EC2 instances, 2 in each subnet

resource "aws_instance" "name" {
  ami = "ami-073130f74f5ffb161"
  instance_type = "t3.micro"
  count = 4
  subnet_id = element(aws_subnet.subnet[*].id, count.index % length(aws_subnet.subnet))
  // 0 % 2 = 0
  // 1 % 2 = 1
  // 2 % 2 = 1
  // 3 % 2 = 1

  tags = {
    Name = "${local.env}-instance-${count.index}"
  }
} 
*/

// This was for Create 2 subnets, create 2 EC2 instances, 1 in each subnet and each EC2 instance belongs to a different OS using count

resource "aws_instance" "main" {
  count = length(var.ec2_config)

  ami           = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type

  subnet_id = element(aws_subnet.subnet[*].id, count.index % length(aws_subnet.subnet))

  tags = {
    Name = "${local.project}-instance-${count.index}"
  }
}

