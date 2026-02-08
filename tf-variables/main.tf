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

resource "aws_instance" "mywebserver" {
    ami             = "ami-04233b5aecce09244"
    instance_type   = var.aws_instance_type

    root_block_device {
      delete_on_termination = true
      volume_size = var.ec2_config.v_size
      volume_type = var.ec2_config.v_type
    }

    /*tags = {
      Name = "mywebserver"
    } */

    tags = merge(var.addition_tags, {
        Name = "mywebserver"
    })
    //what it will do is, it will add additional tags which we will provide outside in variable plus
    // the one which we will mention here.
  
}