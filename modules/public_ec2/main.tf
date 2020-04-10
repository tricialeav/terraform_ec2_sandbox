resource "aws_instance" "public_linux_instances" {
  count                       = length(var.public_subnet_ids)
  ami                         = var.ami
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.public_subnet_ids[count.index]
  associate_public_ip_address = true
  tags = {
    Name = "Public Instance"
  }
  volume_tags = var.tags
}