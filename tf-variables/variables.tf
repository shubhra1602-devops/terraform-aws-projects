variable "aws_instance_type" {
  description = "what type of Instance you want to create"
  type = string //since here default value is not given it will ask in terminal.
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "Only t2 and t3 micro allowed"
  }
}

/*
variable "root_volume_size" {
  description = "What will be the size of the instance"
  type = number
  default = 20 //we can default value as well and can use it anywhere
}

variable "root_volume_type" {
  description = "Define the volume type of the resource"
  type = string
  default = "gp2"
}
*/

variable "ec2_config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 20
    v_type = "gp2"
  }
}

variable "addition_tags" {
  type = map(string) //expecting key=value format
  default = {}
}