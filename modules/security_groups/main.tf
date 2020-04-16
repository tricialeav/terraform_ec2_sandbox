resource "aws_security_group" "sg_public_instances" {
  name        = "sg_public"
  description = "Allow public inbound traffic."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow http from ALB."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_alb.id]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_ip]
  }

  ingress {
    description = "Ping access"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.private_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group" "sg_private_instances" {
  name        = "sg_private"
  description = "Allow traffic from public subnet."
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow http from public subnet."
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_public_instances.id]
  }

  ingress {
    description     = "Allow SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_public_instances.id]
  }

  ingress {
    description     = "Ping access"
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    security_groups = [aws_security_group.sg_public_instances.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group" "sg_alb" {
  name        = "sg_alb"
  description = "Application Load Balancer Security Group."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow http from internet."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    security_group = aws_security_group.sg_public_instances.id
  }

  tags = var.tags
}