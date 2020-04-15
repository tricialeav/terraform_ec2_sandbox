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
  type        = string
}

variable "availability_zones" {
  description = "The AZ for the subnets."
  type        = list(string)
}

variable "total_subnets" {
  description = "The total number of subnets desired."
  type        = number
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}