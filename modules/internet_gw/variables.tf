variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}