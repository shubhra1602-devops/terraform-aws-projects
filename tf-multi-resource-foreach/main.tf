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

resource "aws_instance" "main" {
  for_each = var.ec2_map
  // we will get each,key and each.value

  ami           = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.subnet[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.subnet))

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }

}
