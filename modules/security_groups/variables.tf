variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "sg_cidr_blocks" {
  description = "List of CIDR blocks."
  type        = list(string)
}