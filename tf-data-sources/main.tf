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

//dynamic data source AMI ID
data "aws_ami" "name" {
  most_recent      = true
  owners           = ["amazon"]
}

//dynamic data source AMI ID output
output "aws_ami" {
  value = data.aws_ami.name.id
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

//dynamic data source VPC
data "aws_vpc" "myvpc" {
  tags = {
    Name = "my_vpc"
  }
}

//dynamic data source VPC output
output "vpc" {
  value = data.aws_vpc.myvpc.id
}

//dynamic data source Availability Zone for Same region
data "aws_availability_zones" "az" {
  state = "available"   // Jo bhi available zone hai wo print karo
}

//dynamic data source Availability Zone for Same region Output
output "awa_zones" {
  value = data.aws_availability_zones.az
}

//dynamic data source to get the account details
data "aws_caller_identity" "name" { //aws_caller_identity means is configuration se jo bhi call kar raha 
}
//dynamic data source to get the account details output
output "caller_identity" {
  value = data.aws_caller_identity.name
}

//region
data "aws_region" "name" {  //current region ki info mil jaegi
  
}
//region output
output "region_name" {
  value = data.aws_region.name
}

resource "aws_instance" "mywebserver" {
    ami             = data.aws_ami.name.id
    instance_type   = "t3.micro"

    tags = {
      Name = "mywebserver"
    }
  
}