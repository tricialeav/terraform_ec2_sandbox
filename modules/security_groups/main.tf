resource "aws_security_group" "security_group" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sg_cidr_blocks
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

  tags = var.tags
}