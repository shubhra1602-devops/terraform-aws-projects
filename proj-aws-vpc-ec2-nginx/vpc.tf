// Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

//Create Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet"
  }
}

//Create Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet"
  }
}

//Create Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

// Create Route Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-rt"
  }
}

//Create Route Table Association
resource "aws_route_table_association" "public-sub" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}
