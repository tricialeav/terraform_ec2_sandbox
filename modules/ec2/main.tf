resource "aws_instance" "public_linux_instances" {
  count                       = length(var.subnet_ids)
  ami                         = var.ami
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_ids[count.index]
  associate_public_ip_address = var.associate_public_ip_address
  tags                        = var.ec2_tags
  volume_tags                 = var.tags
}