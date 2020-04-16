variable "name" {
  description = "The name of the application."
  type        = string
}

variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application."
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

