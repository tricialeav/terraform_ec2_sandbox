variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "public" {
  description = "Indicates that the route table is in a public subnet."
  type        = bool
  default     = false
}

variable "cidr_blocks" {
  description = "The CIDR block for the subnet."
  type        = list(string)
}

variable "availability_zone" {
  description = "The AZ for the subnets."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}