variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "private_ip" {
  description = "IP address of user."
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR block for the VPC."
  type        = list(string)
}