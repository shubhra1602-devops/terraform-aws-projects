// this is for actual testing of module, whether the module which we created is working or not
provider "aws" {
  region = "eu-north-1"
}

module "vpc" { //any name - name of the block
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }

  subnet_config = {
    //key = {cidr_block,AZ}
    public_subnet-1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-north-1a"
      public     = false
    }
    public_subnet-2 = {
      cidr_block = "10.0.2.0/24"
      az         = "eu-north-1a"
      public     = false
    }

    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-north-1b"
    }
  }
}
