terraform {}

//Number list
variable "num_list" {
  type      = list(number)
  default   = [ 1,2,3,4,5 ]
}
/*
output "num_list" {
  value = var.num_list
} 
*/

//calculation
locals {
  mul = 2 * 2
  add = 2 + 4
  eq = 2 != 3
}
/*
output "output" {
  value = local.eq
}
*/

//Object list of person
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [ {
    fname = "Raju"
    lname = "Rastogi"
  }, {
    fname = "Sham"
    lname = "Paul"
  } ]
}

//MAP = Key Value Pair
variable "map_list" {
  type = map(number)
  default = {
    "one" = 1
    "two" = 2
    "three" = 3
  }
}

//double the list
locals {
  double = [for num in var.num_list : num*2]
  //odd  number only
  odd = [for num in var.num_list : num if num%2 != 0]
  //To get only fname from person list
  fname = [for person in var.person_list : person.fname]

  //work with map
  map_info = [for key, value in var.map_list : key]

}

output "output" {
  value = local.map_info
}




