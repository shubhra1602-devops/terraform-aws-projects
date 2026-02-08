// 1 EC2 instance = 1 object, 1 EC2 instance has many properties like ami id, instance type etc.
// we will create a variable of type object.
// list(object) - why list? kyunki hamare pass multiple instances has EC2 ke. like 5 tarah ke EC2
// instance banai hai toh 5 list ho gayi. list ke andar jo items hai wo EC2 instance ki puri info hai.
// toh islye wo ek object ho gaya. 

variable "ec2_config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}
