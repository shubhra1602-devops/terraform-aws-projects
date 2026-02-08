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

// Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

// Create Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}

// Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public-subnet"
  }
}

// Create Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

// Routing Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-rt"
  }
}

// AWS Route Table Association
// routing table jo humne abhi banaya aur kaun sa subnet (example - public subnet) kaun se 
// routing table ke sath kaam karega. Subnet and routing table ko link karna iska kaam hai
// Basically ye route kaun se subnet ke liye kaam karega
resource "aws_route_table_association" "public-sub" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

// Create EC2 instance using our VPC
resource "aws_instance" "myserver" {
  ami           = "ami-073130f74f5ffb161"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "myserver"
  }
}


