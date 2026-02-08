terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "main" { //we want to import this which is already created
  // I have created a S3 bucket in AWS manually, I want to use the same bucket which is already created.
  bucket = "shubh-bucket-7feb"
}
