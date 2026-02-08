variable "ec2_map" {
  // key = value, value = object(ami, instance type)
  type = map(object({
    ami           = string
    instance_type = string
  }))
}
