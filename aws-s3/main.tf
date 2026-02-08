terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {  //this is block name not bucket name
  bucket = "demo-bucket-${random_id.rand_id.hex}" // unique bucket name
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.bucket // cloud me ye jo bucket hai usme myfile.txt upload karna hai
  source = "./myfile.txt"  //current location file
  key = "mydata.txt"       //upload it where remotely
}

output "name" {
  value = random_id.rand_id.hex
}