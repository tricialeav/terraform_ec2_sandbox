variable "vpc" {
  description = "Boolean if the EIP is in a VPC or not."
  type        = bool
  default     = true
}

variable "public_instances" {
  description = "EC2 instance ID."
  type        = list(string)
}