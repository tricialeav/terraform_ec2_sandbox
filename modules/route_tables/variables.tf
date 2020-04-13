variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "public" {
  description = "Indicates that the route table is in a public subnet."
  type        = bool
  default     = false
}

variable "public_internet_cidr" {
  description = "CIDR block to allow public access."
  type        = string
  default     = null
}

variable "gateway_id" {
  description = "Identifier of a VPC internet gateway or a virtual private gateway."
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "Identifier of the VPC CIDR block."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "The subnet ID to create an association."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "rt_tags" {
  description = "A mapping of tags to assign to the route table."
  type        = map(string)
}