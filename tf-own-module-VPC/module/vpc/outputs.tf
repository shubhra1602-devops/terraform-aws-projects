// VPC
output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  #To format the subnet IDs which may be multiples in format of subnet_name = {id=, az=}
  public_subnet_output = {
    for key, config in local.public_subnet : key => {
      subnet_id = aws_subnet.subnet_main[key].id
      az        = aws_subnet.subnet_main[key].availability_zone
    }
  }

  private_subnet_output = {
    for key, config in local.private_subnet : key => {
      subnet_id = aws_subnet.subnet_main[key].id
      az        = aws_subnet.subnet_main[key].availability_zone
    }
  }
}

//Output Subnet Details
output "public_subnets" {
  value = local.public_subnet
}

output "private_subnets" {
  value = local.private_subnet
}

