resource "aws_subnet" "private_subnet" {
  for_each          = toset(var.private_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = var.availability_zone

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each          = toset(var.public_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = var.availability_zone

  tags = {
    Name = "Public Subnet"
  }
}