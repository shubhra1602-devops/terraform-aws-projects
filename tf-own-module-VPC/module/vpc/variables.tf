variable "vpc_config" {
  description = "To get the CIDR and Name of VPC from user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  // subnet1 = {cidr_block,AZ} subnet2 = {cidr_block,AZ}
  // key = value    -- MAP
  // Key = subnet1 & subnet2   value = {cidr_block,AZ} & {cidr_block,AZ}
  description = "To get the CIDR and AZ or the subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
  validation { // types of value - MAP(Object) - we can get multiple object means multiple CIDR block
    // sub1 = {cidr..} sub2 = {cidr..}
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}
