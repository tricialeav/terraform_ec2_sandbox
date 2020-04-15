variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "public_tags" {
  description = "Designates a public resource."
  type        = map(string)
}

variable "private_tags" {
  description = "Designates a private resource."
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_internet_cidr" {
  description = "CIDR block to allow public access via ipv4."
  type        = string
}

variable "ipv6_public_internet_cidr" {
  description = "CIDR block to allow public access via ipv6."
  type        = string
}

variable "availability_zones" {
  description = "The AZ for the subnets."
  type        = list(string)
}

variable "private_ip" {
  description = "IP address of user."
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance."
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
