variable "name" {
  description = "The name of the application."
  type        = string
}

variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application."
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "port" {
  description = "The port on which targets receive traffic, unless overridden when registering a specific target. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  type        = string
}

variable "protocol" {
  description = "The protocol to use for routing traffic to the targets. Should be one of 'TCP', 'TLS', 'UDP', 'TCP_UDP', 'HTTP' or 'HTTPS'. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  type        = string
}

variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  type        = string
}

variable "load_balancing_algorithm_type" {
  description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups. The value is round_robin or least_outstanding_requests. The default is round_robin."
  type        = string
}

variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address) or lambda (targets are specified by lambda arn)."
  type        = string
}

variable "target_ids" {
  description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. If the target type is lambda, specify the arn of lambda."
  type        = list(string)
}
