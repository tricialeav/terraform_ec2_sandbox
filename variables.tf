variable "profile" {
  description = "The provider profile to use."
  type        = string
  default     = null
}

variable "key_name" {
  description = "The key pair used to log into the AWS EC2 Instances."
  type        = string
}