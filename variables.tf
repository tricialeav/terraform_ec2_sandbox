variable "profile" {
  description = "The provider profile to use."
  type        = string
}

variable "region" {
  description = "The region used for resource hosting."
  type        = string
}

variable "availability_zone" {
  description = "The Availability Zone used for resource hosting."
  type        = string
}

variable "key_name" {
  description = "The key pair used to log into the AWS EC2 Instances."
  type        = string
}