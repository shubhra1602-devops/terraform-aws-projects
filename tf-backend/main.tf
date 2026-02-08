terraform {
  required_providers {  // this is telling which provider we are going to use
    aws = {     //ye value kuch bhi use kar sakte ho
      source = "hashicorp/aws"  // this is main so thats why we copy this from AWS official page
      version = "6.30.0"
    }
  }
  backend "s3" {   //why Storing EC2 tf state in S3 because we stores files in S3
    bucket = "demo-bucket-b6bb42db94229680"
    key = "backend.tfstate"   // s3 jo hamara resource hai unke andar kis name se is data ko preserve karna hai
    region = "eu-north-1"
  }
}

provider "aws" {    // we need to provide properties like region  # Configuration option
    region = "eu-north-1"
}

resource "aws_instance" "myserver" {    //creating resource block as ec2 instance is a resource
    ami = "ami-073130f74f5ffb161" //Ubuntu
    instance_type = "t3.micro"
    
    tags = {
        Name = "SampleServer"
    }
}

