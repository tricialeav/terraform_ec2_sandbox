output "sg_all_instances" {
  value = aws_security_group.sg_all_instances.id
}

output "sg_public_instances" {
  value = aws_security_group.sg_public_instances.id
}

output "sg_private_instances" {
  value = aws_security_group.sg_private_instances.id
}
