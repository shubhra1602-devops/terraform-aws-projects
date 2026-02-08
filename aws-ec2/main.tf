terraform {
  required_providers {  // this is telling which provider we are going to use
    aws = {     //ye value kuch bhi use kar sakte ho
      source = "hashicorp/aws"  // this is main so thats why we copy this from AWS official page
      version = "6.30.0"
    }
  }
}

provider "aws" {    // we need to provide properties like region  # Configuration option
  //region = "eu-north-1"
    region = var.region
}

resource "aws_instance" "myserver" {    //creating resource block as ec2 instance is a resource
    //ami = "ami-073130f74f5ffb161" //Ubuntu
    ami = "ami-04233b5aecce09244"   //Amazon Linux
    instance_type = "t3.small"
    
    tags = {
        Name = "SampleServer"
    }
}

