output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value = [
    for subnet in aws_subnet.private_subnet :
    subnet.id
  ]
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value = [
    for subnet in aws_subnet.private_subnet :
    subnet.id
  ]
}