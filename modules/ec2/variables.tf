variable "ami" {
  description = "The AMI to use for the instance."
  type        = string
}

variable "availability_zone" {
  description = "The AZ for the subnets."
  type        = string
}

variable "key_name" {
  description = "The key pair used to log into the AWS EC2 Instances."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
}

variable "subnet_ids" {
  description = "The VPC Subnet IDs to launch in."
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "ec2_tags" {
  description = "A mapping of tags to assign to the EC2 instance."
  type        = map(string)
}