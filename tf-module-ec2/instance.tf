module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = "single-instance"

  ami           = "ami-04233b5aecce09244"
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Name        = "module-project-ec2"
    Environment = "dev"
  }
}
