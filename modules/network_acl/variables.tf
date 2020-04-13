variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "outbound_nacl_rules" {
  description = "Specifies an egress rule."
  type        = list(any)
}

variable "inbound_nacl_rules" {
  description = "Specifies an ingress rule."
  type        = list(any)
}

variable "subnet_ids" {
  description = "A list of Subnet IDs to apply the ACL to."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "nacl_tags" {
  description = "A mapping of tags to assign to the Network ACL."
  type        = map(string)
}