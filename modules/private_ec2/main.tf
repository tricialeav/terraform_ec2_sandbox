resource "aws_instance" "private_linux_instances" {
  count                  = length(var.private_subnet_ids)
  ami                    = var.ami
  availability_zone      = var.availability_zone
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.private_subnet_ids[count.index]
  tags = {
    Name = "Private Instance"
  }
  volume_tags = var.tags
}