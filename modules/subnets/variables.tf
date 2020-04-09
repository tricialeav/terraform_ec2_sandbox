variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
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