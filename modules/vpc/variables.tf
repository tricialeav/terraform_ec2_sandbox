variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}