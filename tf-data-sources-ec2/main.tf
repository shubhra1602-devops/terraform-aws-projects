terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

//dynamic data source Security Group
data "aws_security_group" "name" {
  tags = {
    Name = "nginx-sg" // this I have got from AWS console, this we will get from other person whose SG we
                      // we need to use. 
  }
}
//dynamic data source Security Group output
output "security_group" {
  value = data.aws_security_group.name.id
}

//dynamic data source VPC ID
data "aws_vpc" "myvpc" {
  tags = {
    Name ="my_vpc"
  }
}

//dynamic data source VPC ID output
output "VPC-id" {
  value = data.aws_vpc.myvpc.id
}

//dynamic data source Subnet ID - Subnet VPC ke andar rehta hai islye humme VPC ki id chaiye.
data "aws_subnet" "private-subnet" {
  filter {
    name = "vpc-id" //tag name of VPC from AWS Console
    values = [data.aws_vpc.myvpc.id]
  }
  tags = {
    Name = "private-subnet"
  }
}

//dynamic data source Subnet ID Output
output "private-subnet" {
  value = data.aws_subnet.private-subnet.id
}


resource "aws_instance" "mywebserver" { //creating EC2 instance, with Subnet id & SG already created.
    ami             = "ami-04233b5aecce09244"
    instance_type   = "t3.micro"
    subnet_id       =  data.aws_subnet.private-subnet.id
    security_groups = [ data.aws_security_group.name.id ]

    tags = {
      Name = "mywebserver"
    }
  
}