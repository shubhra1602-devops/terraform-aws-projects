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

resource "random_id" "rand_id" {  //random id bucket name ke liye
  byte_length = 8
}

resource "aws_s3_bucket" "mywebaap-bucket" {  //this is block name not bucket name //ek bucket banayi
  bucket = "mywebaap-bucket-${random_id.rand_id.hex}" // unique bucket name
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebaap-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebaap" {
  bucket = aws_s3_bucket.mywebaap-bucket.id
  policy = jsonencode(
    {
    Version = "2012-10-17",		 	 	 
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal =  "*",
            Action = "s3:GetObject"
            Resource = "arn:aws:s3:::${aws_s3_bucket.mywebaap-bucket.id}/*"
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "mywebaap" {
  bucket = aws_s3_bucket.mywebaap-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.mywebaap-bucket.bucket
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.mywebaap-bucket.bucket
  key          = "styles.css"
  source       = "./styles.css"
  content_type = "text/css"
}


output "name" {
  value = aws_s3_bucket_website_configuration.mywebaap.website_endpoint
}