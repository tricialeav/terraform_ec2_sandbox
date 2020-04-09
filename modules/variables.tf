variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "private_subnet_cidr_blocks" {
  description = "The CIDR block for the VPC."
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR block for the VPC."
  type        = list(string)
}

variable "availability_zone" {
  description = "The AZ for the subnets."
  type        = string
}

variable "sg_cidr_blocks" {
  description = "List of CIDR blocks."
  type        = list(string)
}