terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {                                 //this is block name not bucket name
  bucket = "demo-bucket-${terraform.workspace}-${random_id.rand_id.hex}" // unique bucket name
}
